import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomThemeExtension extends ThemeExtension<CustomThemeExtension> {
  final Color primaryColor;
  final Color logoColor;
  final Gradient gradientBgColor;
  final Color cardBgColor;
  final Color primaryTextColor;

  const CustomThemeExtension({
    required this.primaryColor,
    required this.logoColor,
    required this.gradientBgColor,
    required this.cardBgColor,
    required this.primaryTextColor,
  });

  static final lightTheme = const CustomThemeExtension(
    primaryColor: AppColors.primaryLight,
    logoColor: AppColors.logoLight,
    gradientBgColor: AppColors.gradientBgLight,
    cardBgColor: AppColors.cardBgLight,
    primaryTextColor: AppColors.primaryTextLight,
  );

  static final darkTheme = const CustomThemeExtension(
    primaryColor: AppColors.primaryDark,
    logoColor: AppColors.logoDark,
    gradientBgColor: AppColors.gradientBgDark,
    cardBgColor: AppColors.cardBgDark,
    primaryTextColor: AppColors.primaryTextDark,
  );

  @override
  ThemeExtension<CustomThemeExtension> copyWith({
    Color? primaryColor,
    Color? logoColor,
    Gradient? gradientBgColor,
    Color? cardBgColor,
    Color? primaryTextColor,
  }) {
    return CustomThemeExtension(
      primaryColor: primaryColor ?? this.primaryColor,
      logoColor: logoColor ?? this.logoColor,
      gradientBgColor: gradientBgColor ?? this.gradientBgColor,
      cardBgColor: cardBgColor ?? this.cardBgColor,
      primaryTextColor: primaryTextColor ?? this.primaryTextColor,
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
      gradientBgColor: Gradient.lerp(
        gradientBgColor,
        other.gradientBgColor,
        t,
      )!,
      cardBgColor: Color.lerp(cardBgColor, other.cardBgColor, t)!,
      primaryTextColor: Color.lerp(
        primaryTextColor,
        other.primaryTextColor,
        t,
      )!,
    );
  }
}

extension ExtendedThemeExtension on BuildContext {
  CustomThemeExtension get theme =>
      Theme.of(this).extension<CustomThemeExtension>()!;
}
