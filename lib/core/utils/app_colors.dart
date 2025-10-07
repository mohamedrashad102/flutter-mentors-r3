import 'package:flutter/material.dart';

abstract class AppColors {
  // ** common colors **
  static const Color secondaryText = Color(0xFF8F959E);

  // ** light colors **
  static const Color primaryLight = Color(0XFF9775FA);
  static const Color logoLight = Color(0XFFFFFFFF);
  static const Color cardBgLight = Color(0XFFFFFFFF);
  static const Color primaryTextLight = Color(0xFF1D1E20);

  // ** light gradient **
  static const Gradient gradientBgLight = LinearGradient(
    colors: [Color(0XFFB0A3E5), Color(0XFF7661C5)],
  );
}