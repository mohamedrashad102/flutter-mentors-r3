import 'package:flutter/widgets.dart';

import '../widgets/custom_snackbar.dart';

extension CustomSnackbarX on BuildContext {
  void showCustomSnackbar({
    required String message,
    String? title,
    SnackBarVariant variant = SnackBarVariant.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    AppSnackBar.show(
      this,
      message: message,
      title: title,
      variant: variant,
      duration: duration,
      actionLabel: actionLabel,
      onAction: onAction,
    );
  }
}
