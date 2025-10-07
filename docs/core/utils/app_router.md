### 📄 `app_router.dart`

#### 🧩 Purpose

Defines and configures the application's routes using the `go_router` package.

#### ⚙️ Classes / Functions

*   `abstract class AppRouter`: A class that holds route paths and the main router instance.
    *   `static const String splash`: The path for the splash screen (`/`).
    *   `static const String welcome`: The path for the welcome screen (`/welcome`).
    *   `static const String login`: The path for the login screen (`/login`).
    *   `static const String register`: The path for the register screen (`/register`).
    *   `static const String verifyEmail`: The path for the email verification screen (`/verify-email`).
    *   `static final GoRouter router`: The configured `GoRouter` instance for the application.
