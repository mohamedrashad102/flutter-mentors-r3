### 📄 `dio_helper.dart`

#### 🧩 Purpose

Provides a singleton wrapper around the Dio package to handle all HTTP network requests.

#### ⚙️ Classes / Functions

*   `class TokenResponse`: A model representing the API response for token-related requests.
    *   `TokenResponse({required String accessToken, required String refreshToken})`: Creates a token response object.
*   `class DioHelper`: A singleton class that manages Dio configurations, interceptors, and requests.
    *   `static DioHelper get instance`: Returns the single, shared instance of the helper.
    *   `void initialize(...)`: Sets up the base URL, timeouts, tokens, and interceptors for the Dio client.
    *   `void setAccessToken(String token)`: Sets the authorization token for all subsequent requests.
    *   `void clearTokens()`: Removes the authorization token.
    *   `Future<Response<T>> get<T>(String path, ...)`: Performs a GET request.
    *   `Future<Response<T>> post<T>(String path, ...)`: Performs a POST request.
    *   `Future<Response<T>> put<T>(String path, ...)`: Performs a PUT request.
    *   `Future<Response<T>> delete<T>(String path, ...)`: Performs a DELETE request.
