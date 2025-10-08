### 📄 `custom_snackbar.dart`

#### 🧩 Purpose

Provides a reusable helper to show consistently styled SnackBars (info/success/error) across the app.

#### ⚙️ Classes / Functions

* `enum SnackBarVariant { info, success, error }`: Defines visual variants for the snackbar.
* `class AppSnackBar`: Utility for displaying snackbars.
  * `static void show(BuildContext context, {required String message, String? title, SnackBarVariant variant = SnackBarVariant.info, Duration duration = const Duration(seconds: 3), String? actionLabel, VoidCallback? onAction})`: Shows a floating snackbar with optional title, action, and variant-based styling.
