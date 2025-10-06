import 'package:flutter/material.dart';
import '../extensions/theme_extension.dart';

class AppTheme {
  static ThemeData lightTheme() {
    return ThemeData.light().copyWith(
      extensions: [CustomThemeExtension.lightTheme],
    );
  }

  static ThemeData darkTheme() {
    return ThemeData.dark().copyWith(
      extensions: [CustomThemeExtension.darkTheme],
    );
  }
}
