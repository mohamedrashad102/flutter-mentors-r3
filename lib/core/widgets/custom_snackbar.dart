import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// Variants for the custom snackbar styling and iconography.
enum SnackBarVariant { info, success, error }

/// Helper for showing a consistently styled SnackBar across the app.
class AppSnackBar {
  /// Shows a floating SnackBar with consistent styling.
  ///
  /// Parameters:
  /// - [context]: Build context used to find the ScaffoldMessenger.
  /// - [message]: Main message text.
  /// - [title]: Optional title displayed above the message.
  /// - [variant]: Controls color and icon (info/success/error). Defaults to [SnackBarVariant.info].
  /// - [duration]: Display duration. Defaults to 3 seconds.
  /// - [actionLabel]: Optional action button label.
  /// - [onAction]: Callback for action button if [actionLabel] is provided.
  static void show(
    BuildContext context, {
    required String message,
    String? title,
    SnackBarVariant variant = SnackBarVariant.info,
    Duration duration = const Duration(seconds: 3),
    String? actionLabel,
    VoidCallback? onAction,
  }) {
    final Color background = _backgroundFor(variant);
    final IconData icon = _iconFor(variant);

    final content = Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: AppColors.logoLight),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (title != null && title.isNotEmpty)
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.logoLight,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              Text(message, style: const TextStyle(color: AppColors.logoLight)),
            ],
          ),
        ),
      ],
    );

    final snackBar = SnackBar(
      content: content,
      backgroundColor: background,
      behavior: SnackBarBehavior.floating,
      duration: duration,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(12),
      action: actionLabel != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: AppColors.logoLight,
              onPressed: onAction ?? () {},
            )
          : null,
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static Color _backgroundFor(SnackBarVariant variant) {
    switch (variant) {
      case SnackBarVariant.success:
        return const Color(0xFF2E7D32); // green 800
      case SnackBarVariant.error:
        return const Color(0xFFC62828); // red 800
      case SnackBarVariant.info:
        return AppColors.primaryLight;
    }
  }

  static IconData _iconFor(SnackBarVariant variant) {
    switch (variant) {
      case SnackBarVariant.success:
        return Icons.check_circle_outline;
      case SnackBarVariant.error:
        return Icons.error_outline;
      case SnackBarVariant.info:
        return Icons.info_outline;
    }
  }
}
