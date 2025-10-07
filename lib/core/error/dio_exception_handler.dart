import 'package:dio/dio.dart';

/// Custom exception types for better error handling
enum ApiExceptionType {
  /// Network related errors
  network,

  /// Bad request (400)
  badRequest,

  /// Unauthorized (401)
  unauthorized,

  /// Forbidden (403)
  forbidden,

  /// Not found (404)
  notFound,

  /// Request timeout (408)
  requestTimeout,

  /// Conflict (409)
  conflict,

  /// Validation error (422)
  validationError,

  /// Too many requests (429)
  tooManyRequests,

  /// Internal server error (500)
  internalServerError,

  /// Bad gateway (502)
  badGateway,

  /// Service unavailable (503)
  serviceUnavailable,

  /// Gateway timeout (504)
  gatewayTimeout,

  /// Request cancelled
  requestCancelled,

  /// Connection timeout
  connectionTimeout,

  /// Send timeout
  sendTimeout,

  /// Receive timeout
  receiveTimeout,

  /// Bad certificate
  badCertificate,

  /// Unknown error
  unknown,
}

/// Custom API Exception class
class ApiException implements Exception {
  /// Exception type
  final ApiExceptionType type;

  /// Error message
  final String message;

  /// HTTP status code
  final int? statusCode;

  /// Original DioException
  final DioException? dioException;

  /// Response data
  final dynamic responseData;

  /// Request path
  final String? requestPath;

  /// Request method
  final String? requestMethod;

  /// Error details (for validation errors)
  final Map<String, dynamic>? errorDetails;

  ApiException({
    required this.type,
    required this.message,
    this.statusCode,
    this.dioException,
    this.responseData,
    this.requestPath,
    this.requestMethod,
    this.errorDetails,
  });

  @override
  String toString() {
    return 'ApiException: $message (Type: $type, Status: $statusCode)';
  }

  /// Check if error is a network error
  bool get isNetworkError => type == ApiExceptionType.network;

  /// Check if error is an authentication error
  bool get isAuthError => type == ApiExceptionType.unauthorized;

  /// Check if error is a validation error
  bool get isValidationError => type == ApiExceptionType.validationError;

  /// Check if error is a server error
  bool get isServerError =>
      type == ApiExceptionType.internalServerError ||
      type == ApiExceptionType.badGateway ||
      type == ApiExceptionType.serviceUnavailable ||
      type == ApiExceptionType.gatewayTimeout;

  /// Check if request was cancelled
  bool get isCancelled => type == ApiExceptionType.requestCancelled;

  /// Check if error is a timeout error
  bool get isTimeout =>
      type == ApiExceptionType.connectionTimeout ||
      type == ApiExceptionType.sendTimeout ||
      type == ApiExceptionType.receiveTimeout ||
      type == ApiExceptionType.requestTimeout;
}

/// DioException handler class
class DioExceptionHandler {
  /// Convert DioException to ApiException
  static ApiException handleException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return _handleConnectionTimeout(error);

      case DioExceptionType.sendTimeout:
        return _handleSendTimeout(error);

      case DioExceptionType.receiveTimeout:
        return _handleReceiveTimeout(error);

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return _handleCancel(error);

      case DioExceptionType.connectionError:
        return _handleConnectionError(error);

      case DioExceptionType.badCertificate:
        return _handleBadCertificate(error);

      case DioExceptionType.unknown:
        return _handleUnknown(error);
    }
  }

  /// Handle connection timeout
  static ApiException _handleConnectionTimeout(DioException error) {
    return ApiException(
      type: ApiExceptionType.connectionTimeout,
      message:
          'Connection timeout. Please check your internet connection and try again.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Handle send timeout
  static ApiException _handleSendTimeout(DioException error) {
    return ApiException(
      type: ApiExceptionType.sendTimeout,
      message:
          'Send timeout. The request took too long to send. Please try again.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Handle receive timeout
  static ApiException _handleReceiveTimeout(DioException error) {
    return ApiException(
      type: ApiExceptionType.receiveTimeout,
      message:
          'Receive timeout. The server took too long to respond. Please try again.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Handle bad response (HTTP errors)
  static ApiException _handleBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;
    final responseData = error.response?.data;

    // Try to extract error message from response
    String errorMessage = _extractErrorMessage(responseData);
    Map<String, dynamic>? errorDetails = _extractValidationErrors(responseData);

    switch (statusCode) {
      case 400:
        return ApiException(
          type: ApiExceptionType.badRequest,
          message: errorMessage.isEmpty
              ? 'Bad request. Please check your input and try again.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
          errorDetails: errorDetails,
        );

      case 401:
        return ApiException(
          type: ApiExceptionType.unauthorized,
          message: errorMessage.isEmpty
              ? 'Unauthorized. Please login again.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 403:
        return ApiException(
          type: ApiExceptionType.forbidden,
          message: errorMessage.isEmpty
              ? 'Forbidden. You don\'t have permission to access this resource.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 404:
        return ApiException(
          type: ApiExceptionType.notFound,
          message: errorMessage.isEmpty ? 'Resource not found.' : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 408:
        return ApiException(
          type: ApiExceptionType.requestTimeout,
          message: errorMessage.isEmpty
              ? 'Request timeout. Please try again.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 409:
        return ApiException(
          type: ApiExceptionType.conflict,
          message: errorMessage.isEmpty
              ? 'Conflict. The resource already exists or there is a conflict.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 422:
        return ApiException(
          type: ApiExceptionType.validationError,
          message: errorMessage.isEmpty
              ? 'Validation error. Please check your input.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
          errorDetails: errorDetails,
        );

      case 429:
        return ApiException(
          type: ApiExceptionType.tooManyRequests,
          message: errorMessage.isEmpty
              ? 'Too many requests. Please try again later.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 500:
        return ApiException(
          type: ApiExceptionType.internalServerError,
          message: errorMessage.isEmpty
              ? 'Internal server error. Please try again later.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 502:
        return ApiException(
          type: ApiExceptionType.badGateway,
          message: errorMessage.isEmpty
              ? 'Bad gateway. Please try again later.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 503:
        return ApiException(
          type: ApiExceptionType.serviceUnavailable,
          message: errorMessage.isEmpty
              ? 'Service unavailable. Please try again later.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      case 504:
        return ApiException(
          type: ApiExceptionType.gatewayTimeout,
          message: errorMessage.isEmpty
              ? 'Gateway timeout. Please try again later.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );

      default:
        return ApiException(
          type: ApiExceptionType.unknown,
          message: errorMessage.isEmpty
              ? 'An error occurred. Please try again.'
              : errorMessage,
          statusCode: statusCode,
          dioException: error,
          responseData: responseData,
          requestPath: error.requestOptions.path,
          requestMethod: error.requestOptions.method,
        );
    }
  }

  /// Handle request cancellation
  static ApiException _handleCancel(DioException error) {
    return ApiException(
      type: ApiExceptionType.requestCancelled,
      message: 'Request was cancelled.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Handle connection error
  static ApiException _handleConnectionError(DioException error) {
    return ApiException(
      type: ApiExceptionType.network,
      message:
          'No internet connection. Please check your network and try again.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Handle bad certificate
  static ApiException _handleBadCertificate(DioException error) {
    return ApiException(
      type: ApiExceptionType.badCertificate,
      message: 'Security certificate error. Please try again.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Handle unknown error
  static ApiException _handleUnknown(DioException error) {
    return ApiException(
      type: ApiExceptionType.unknown,
      message:
          error.message ?? 'An unexpected error occurred. Please try again.',
      dioException: error,
      requestPath: error.requestOptions.path,
      requestMethod: error.requestOptions.method,
    );
  }

  /// Extract error message from response data
  static String _extractErrorMessage(dynamic responseData) {
    if (responseData == null) return '';

    try {
      if (responseData is Map) {
        // Common error message keys
        final messageKeys = [
          'message',
          'error',
          'msg',
          'detail',
          'details',
          'errorMessage',
        ];

        for (final key in messageKeys) {
          if (responseData.containsKey(key) && responseData[key] is String) {
            return responseData[key] as String;
          }
        }

        // Try nested error object
        if (responseData.containsKey('error') && responseData['error'] is Map) {
          final errorObj = responseData['error'] as Map;
          for (final key in messageKeys) {
            if (errorObj.containsKey(key) && errorObj[key] is String) {
              return errorObj[key] as String;
            }
          }
        }
      } else if (responseData is String) {
        return responseData;
      }
    } catch (e) {
      return '';
    }

    return '';
  }

  /// Extract validation errors from response data
  static Map<String, dynamic>? _extractValidationErrors(dynamic responseData) {
    print('-' * 50);
    print(responseData);
    print('-' * 50);
    if (responseData == null) return null;

    try {
      if (responseData is Map) {
        // Common validation error keys
        if (responseData.containsKey('errors') &&
            responseData['errors'] is Map) {
          return Map<String, dynamic>.from(responseData['errors'] as Map);
        }

        if (responseData.containsKey('validationErrors') &&
            responseData['validationErrors'] is Map) {
          return Map<String, dynamic>.from(
            responseData['validationErrors'] as Map,
          );
        }

        if (responseData.containsKey('fields') &&
            responseData['fields'] is Map) {
          return Map<String, dynamic>.from(responseData['fields'] as Map);
        }
      }
    } catch (e) {
      return null;
    }

    return null;
  }

  /// Get user-friendly error message
  static String getUserFriendlyMessage(ApiException exception) {
    return exception.message;
  }

  /// Get validation error message for a specific field
  static String? getFieldError(ApiException exception, String fieldName) {
    if (exception.errorDetails == null) return null;

    final fieldError = exception.errorDetails![fieldName];
    if (fieldError == null) return null;

    if (fieldError is String) {
      return fieldError;
    } else if (fieldError is List && fieldError.isNotEmpty) {
      return fieldError.first.toString();
    }

    return null;
  }

  /// Get all validation errors as formatted string
  static String getValidationErrorsString(ApiException exception) {
    if (exception.errorDetails == null || exception.errorDetails!.isEmpty) {
      return exception.message;
    }

    final errors = <String>[];
    exception.errorDetails!.forEach((field, error) {
      if (error is String) {
        errors.add('$field: $error');
      } else if (error is List && error.isNotEmpty) {
        errors.add('$field: ${error.first}');
      }
    });

    return errors.isEmpty ? exception.message : errors.join('\n');
  }
}
