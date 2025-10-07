### 📄 `dio_exception_handler.dart`

#### 🧩 Purpose

Converts generic `DioException`s into structured `ApiException`s with specific types and messages.

#### ⚙️ Classes / Functions

*   `enum ApiExceptionType`: Defines a set of specific API error types (e.g., `network`, `unauthorized`, `notFound`).
*   `class ApiException`: A custom exception class that holds the error type, message, and other details.
*   `class DioExceptionHandler`: A handler that converts a `DioException` into a more specific `ApiException`.
    *   `static ApiException handleException(DioException error)`: Returns a specific `ApiException` based on the `DioException` type and response code.
    *   `static String? getFieldError(ApiException exception, String fieldName)`: Extracts a validation error for a specific field from the exception details.
