### 1. Purpose
Provides a `showCustomSnackbar` extension method on `BuildContext` to easily display a custom snackbar.

### 2. Functions
- `showCustomSnackbar({required String message, String? title, SnackBarVariant variant, Duration duration, String? actionLabel, VoidCallback? onAction}) -> void`: Shows a customized `AppSnackBar` by extending `BuildContext`.