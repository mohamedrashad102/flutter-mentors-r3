### 📄 `failure.dart`

#### 🧩 Purpose

Defines the base `Failure` class and its specific implementations for consistent error handling.

#### ⚙️ Classes / Functions

*   `abstract class Failure`: The base class for all failures in the application.
    *   `Failure(String message, {Map<String, dynamic>? errorDetails})`: Constructor for creating a failure instance.
*   `class ServerFailure extends Failure`: Represents an error that occurred on the server.
*   `class CacheFailure extends Failure`: Represents an error related to local data caching.
