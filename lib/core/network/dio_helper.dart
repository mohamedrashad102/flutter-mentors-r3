import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

/// Callback function for token refresh
typedef TokenRefreshCallback =
    Future<TokenResponse> Function(String refreshToken);

/// Token response model
class TokenResponse {
  final String accessToken;
  final String refreshToken;

  TokenResponse({required this.accessToken, required this.refreshToken});
}

/// Advanced Dio HTTP client wrapper with comprehensive features
class DioHelper {
  static DioHelper? _instance;
  late Dio _dio;
  CancelToken? _cancelToken;

  // Token management
  String? _accessToken;
  String? _refreshToken;
  TokenRefreshCallback? _tokenRefreshCallback;
  bool _isRefreshing = false;
  final List<({RequestOptions options, ErrorInterceptorHandler handler})>
  _pendingRequests = [];

  // Private constructor for singleton
  DioHelper._internal();

  /// Get singleton instance
  static DioHelper get instance {
    _instance ??= DioHelper._internal();
    return _instance!;
  }

  /// Get current access token
  String? get accessToken => _accessToken;

  /// Get current refresh token
  String? get refreshToken => _refreshToken;

  /// Initialize DioHelper with configuration
  void initialize({
    required String baseUrl,
    Duration connectTimeout = const Duration(seconds: 30),
    Duration receiveTimeout = const Duration(seconds: 30),
    Duration sendTimeout = const Duration(seconds: 30),
    Map<String, dynamic>? headers,
    String? accessToken,
    String? refreshToken,
    TokenRefreshCallback? onRefreshToken,
    bool enableLogging = true,
    bool enableTokenRefresh = true,
  }) {
    _dio = Dio();

    // Store tokens
    _accessToken = accessToken;
    _refreshToken = refreshToken;
    _tokenRefreshCallback = onRefreshToken;

    // Base configuration
    _dio.options = BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: connectTimeout,
      receiveTimeout: receiveTimeout,
      sendTimeout: sendTimeout,
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        ...?headers,
      },
    );

    // Add access token if provided
    if (accessToken != null) {
      setAccessToken(accessToken);
    }

    // Add interceptors
    _addInterceptors(enableLogging, enableTokenRefresh);
  }

  /// Add interceptors for logging, headers, and error handling
  void _addInterceptors(bool enableLogging, bool enableTokenRefresh) {
    // Request interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          if (kDebugMode && enableLogging) {
            print('🚀 REQUEST[${options.method}] => PATH: ${options.path}');
            print('Headers: ${options.headers}');
            if (options.data != null) {
              print('Data: ${options.data}');
            }
            if (options.queryParameters.isNotEmpty) {
              print('Query Parameters: ${options.queryParameters}');
            }
          }
          handler.next(options);
        },
        onResponse: (response, handler) {
          if (kDebugMode && enableLogging) {
            print(
              '✅ RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}',
            );
            print('Data: ${response.data}');
          }
          handler.next(response);
        },
        onError: (error, handler) {
          if (kDebugMode && enableLogging) {
            print(
              '❌ ERROR[${error.response?.statusCode}] => PATH: ${error.requestOptions.path}',
            );
            print('Message: ${error.message}');
            if (error.response?.data != null) {
              print('Error Data: ${error.response?.data}');
            }
          }
          handler.next(error);
        },
      ),
    );

    // Token refresh interceptor (add before error handling interceptor)
    if (enableTokenRefresh) {
      _dio.interceptors.add(
        InterceptorsWrapper(
          onError: (error, handler) async {
            // Check if error is 401 and we have refresh token
            if (error.response?.statusCode == 401 &&
                _refreshToken != null &&
                _tokenRefreshCallback != null &&
                !_isRefreshing) {
              // Prevent multiple refresh attempts
              _isRefreshing = true;

              try {
                // Call the refresh token callback
                final tokenResponse = await _tokenRefreshCallback!(
                  _refreshToken!,
                );

                // Update tokens
                setAccessToken(tokenResponse.accessToken);
                setRefreshToken(tokenResponse.refreshToken);

                // Retry the failed request with new token
                error.requestOptions.headers['Authorization'] =
                    'Bearer ${tokenResponse.accessToken}';

                final response = await _dio.fetch(error.requestOptions);

                // Resolve all pending requests with new token
                _retryPendingRequests(tokenResponse.accessToken);

                _isRefreshing = false;
                handler.resolve(response);
                return;
              } catch (e) {
                _isRefreshing = false;
                // Clear tokens on refresh failure
                clearTokens();
                // Reject all pending requests
                _rejectPendingRequests(error);
                handler.reject(error);
                return;
              }
            } else if (_isRefreshing && error.response?.statusCode == 401) {
              // Queue the request if token refresh is in progress
              _pendingRequests.add((
                options: error.requestOptions,
                handler: handler,
              ));
              return;
            }

            handler.next(error);
          },
        ),
      );
    }

    // Error handling interceptor
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) {
          final dioException = _handleDioError(error);
          handler.reject(dioException);
        },
      ),
    );
  }

  /// Retry all pending requests with new access token
  void _retryPendingRequests(String newAccessToken) {
    for (final pending in _pendingRequests) {
      pending.options.headers['Authorization'] = 'Bearer $newAccessToken';
      _dio
          .fetch(pending.options)
          .then(
            (response) => pending.handler.resolve(response),
            onError: (error) => pending.handler.reject(error as DioException),
          );
    }
    _pendingRequests.clear();
  }

  /// Reject all pending requests
  void _rejectPendingRequests(DioException error) {
    for (final pending in _pendingRequests) {
      pending.handler.reject(error);
    }
    _pendingRequests.clear();
  }

  /// Handle Dio errors and provide meaningful error messages
  DioException _handleDioError(DioException error) {
    String errorMessage;

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        errorMessage =
            'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        errorMessage = 'Send timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receive timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        errorMessage = _handleHttpError(error.response?.statusCode);
        break;
      case DioExceptionType.cancel:
        errorMessage = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        errorMessage = 'No internet connection. Please check your network.';
        break;
      case DioExceptionType.badCertificate:
        errorMessage = 'Certificate error. Please try again.';
        break;
      case DioExceptionType.unknown:
        errorMessage = 'An unexpected error occurred. Please try again.';
        break;
    }

    return DioException(
      requestOptions: error.requestOptions,
      response: error.response,
      type: error.type,
      error: errorMessage,
      message: errorMessage,
    );
  }

  /// Handle HTTP status code errors
  String _handleHttpError(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'Bad request. Please check your input.';
      case 401:
        return 'Unauthorized. Please login again.';
      case 403:
        return 'Forbidden. You don\'t have permission to access this resource.';
      case 404:
        return 'Resource not found.';
      case 408:
        return 'Request timeout. Please try again.';
      case 409:
        return 'Conflict. The resource already exists.';
      case 422:
        return 'Validation error. Please check your input.';
      case 429:
        return 'Too many requests. Please try again later.';
      case 500:
        return 'Internal server error. Please try again later.';
      case 502:
        return 'Bad gateway. Please try again later.';
      case 503:
        return 'Service unavailable. Please try again later.';
      case 504:
        return 'Gateway timeout. Please try again later.';
      default:
        return 'An error occurred. Please try again.';
    }
  }

  /// Set access token
  void setAccessToken(String token, {String tokenType = 'Bearer'}) {
    _accessToken = token;
    _dio.options.headers['Authorization'] = '$tokenType $token';
  }

  /// Set refresh token
  void setRefreshToken(String token) {
    _refreshToken = token;
  }

  /// Set both access and refresh tokens
  void setTokens({
    required String accessToken,
    required String refreshToken,
    String tokenType = 'Bearer',
  }) {
    setAccessToken(accessToken, tokenType: tokenType);
    setRefreshToken(refreshToken);
  }

  /// Update token refresh callback
  void setTokenRefreshCallback(TokenRefreshCallback callback) {
    _tokenRefreshCallback = callback;
  }

  /// Clear all tokens
  void clearTokens() {
    _accessToken = null;
    _refreshToken = null;
    _dio.options.headers.remove('Authorization');
  }

  /// Check if tokens are available
  bool get hasTokens => _accessToken != null && _refreshToken != null;

  /// Check if only access token is available
  bool get hasAccessToken => _accessToken != null;

  /// Manually refresh token
  Future<void> refreshTokenManually() async {
    if (_refreshToken == null || _tokenRefreshCallback == null) {
      throw Exception('Refresh token or callback not available');
    }

    try {
      _isRefreshing = true;
      final tokenResponse = await _tokenRefreshCallback!(_refreshToken!);
      setAccessToken(tokenResponse.accessToken);
      setRefreshToken(tokenResponse.refreshToken);
    } catch (e) {
      clearTokens();
      rethrow;
    } finally {
      _isRefreshing = false;
    }
  }

  /// Set authentication token (deprecated - use setAccessToken)
  @Deprecated('Use setAccessToken instead')
  void setAuthToken(String token, {String tokenType = 'Bearer'}) {
    setAccessToken(token, tokenType: tokenType);
  }

  /// Remove authentication token (deprecated - use clearTokens)
  @Deprecated('Use clearTokens instead')
  void removeAuthToken() {
    clearTokens();
  }

  /// Set custom headers
  void setHeaders(Map<String, dynamic> headers) {
    _dio.options.headers.addAll(headers);
  }

  /// Remove specific header
  void removeHeader(String key) {
    _dio.options.headers.remove(key);
  }

  /// Update base URL
  void updateBaseUrl(String baseUrl) {
    _dio.options.baseUrl = baseUrl;
  }

  /// Create new cancel token
  CancelToken createCancelToken() {
    _cancelToken = CancelToken();
    return _cancelToken!;
  }

  /// Cancel current request
  void cancelRequest([String? reason]) {
    _cancelToken?.cancel(reason ?? 'Request cancelled by user');
  }

  /// GET request
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.get<T>(
        path,
        queryParameters: queryParameters,
        options: _buildOptions(options, headers),
        cancelToken: cancelToken ?? _cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// POST request
  Future<Response<T>> post<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(options, headers),
        cancelToken: cancelToken ?? _cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PUT request
  Future<Response<T>> put<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.put<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(options, headers),
        cancelToken: cancelToken ?? _cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// DELETE request
  Future<Response<T>> delete<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.delete<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(options, headers),
        cancelToken: cancelToken ?? _cancelToken,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// PATCH request
  Future<Response<T>> patch<T>(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.patch<T>(
        path,
        data: data,
        queryParameters: queryParameters,
        options: _buildOptions(options, headers),
        cancelToken: cancelToken ?? _cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Upload file
  Future<Response<T>> uploadFile<T>(
    String path,
    String filePath, {
    String? fileName,
    Map<String, dynamic>? data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onSendProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final formData = FormData.fromMap({
        ...?data,
        'file': await MultipartFile.fromFile(filePath, filename: fileName),
      });

      final response = await _dio.post<T>(
        path,
        data: formData,
        queryParameters: queryParameters,
        options: _buildOptions(options, headers),
        cancelToken: cancelToken ?? _cancelToken,
        onSendProgress: onSendProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Download file
  Future<Response> downloadFile(
    String urlPath,
    String savePath, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
    bool deleteOnError = true,
    String lengthHeader = Headers.contentLengthHeader,
    Options? options,
    ProgressCallback? onReceiveProgress,
    Map<String, dynamic>? headers,
  }) async {
    try {
      final response = await _dio.download(
        urlPath,
        savePath,
        queryParameters: queryParameters,
        cancelToken: cancelToken ?? _cancelToken,
        deleteOnError: deleteOnError,
        lengthHeader: lengthHeader,
        options: _buildOptions(options, headers),
        onReceiveProgress: onReceiveProgress,
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  /// Build options with custom headers
  Options _buildOptions(Options? options, Map<String, dynamic>? headers) {
    if (headers == null) return options ?? Options();

    final mergedHeaders = <String, dynamic>{...?options?.headers, ...headers};

    return (options ?? Options()).copyWith(headers: mergedHeaders);
  }

  /// Get current Dio instance (use carefully)
  Dio get dio => _dio;

  /// Clear all headers
  void clearHeaders() {
    _dio.options.headers.clear();
    // Re-add essential headers
    _dio.options.headers.addAll({
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
  }

  /// Add retry interceptor
  void addRetryInterceptor({
    int retries = 3,
    List<int> retryStatuses = const [502, 503, 504],
  }) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onError: (error, handler) async {
          if (retryStatuses.contains(error.response?.statusCode) &&
              error.requestOptions.extra['retryCount'] == null) {
            error.requestOptions.extra['retryCount'] = 0;
          }

          final retryCount = error.requestOptions.extra['retryCount'] ?? 0;

          if (retryCount < retries &&
              retryStatuses.contains(error.response?.statusCode)) {
            error.requestOptions.extra['retryCount'] = retryCount + 1;

            // Add delay before retry
            await Future.delayed(Duration(seconds: retryCount + 1));

            try {
              final response = await _dio.fetch(error.requestOptions);
              handler.resolve(response);
            } catch (e) {
              handler.next(error);
            }
          } else {
            handler.next(error);
          }
        },
      ),
    );
  }
}
