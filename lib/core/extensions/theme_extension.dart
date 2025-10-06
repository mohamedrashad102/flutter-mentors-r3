import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color primaryColor;
  final Color logoColor;

  const CustomThemeExtension({
    required this.primaryColor,
    required this.logoColor,
  });

  static final lightTheme = const CustomThemeExtension(
    primaryColor: AppColors.primaryLight,
    logoColor: AppColors.logoLight,
  );

  static final darkTheme = const CustomThemeExtension(
    primaryColor: AppColors.primaryDark,
    logoColor: AppColors.logoDark,
  );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? primaryColor,
    Color? logoColor,
  }) {
    return CustomThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      logoColor: logoColor ?? this.logoColor,
    );
  }

  @override
  ThemeExtension<CustomThemeExtension> lerp(
    covariant ThemeExtension<CustomThemeExtension>? other,
    double t,
  ) {
    if (other is! CustomThemeExtension) {
      return this;
    }
    return CustomThemeExtension(
      primaryColor: Color.lerp(primaryColor, other.primaryColor, t)!,
      logoColor: Color.lerp(logoColor, other.logoColor, t)!,
    );
  }
}

extension ExtendedThemeExtension on BuildContext {
  CustomThemeExtension get theme =>
      Theme.of(this).extension<CustomThemeExtension>()!;
}
