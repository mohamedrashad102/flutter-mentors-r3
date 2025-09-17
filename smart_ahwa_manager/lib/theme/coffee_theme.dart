import 'package:flutter/material.dart';

class CoffeeColors {
  // Coffee Theme Color Palette
  static const Color primaryBrown = Color(0xFF8B4513); // Saddle Brown
  static const Color darkBrown = Color(0xFF5D2F0A); // Dark Coffee
  static const Color lightBrown = Color(0xFFD2B48C); // Tan
  static const Color cream = Color(0xFFF5F5DC); // Beige
  static const Color espresso = Color(0xFF3C2415); // Very Dark Brown
  static const Color mocha = Color(0xFF7B3F00); // Chocolate Brown

  // Status Colors
  static const Color pendingOrange = Color(0xFFFF8C00); // Dark Orange
  static const Color completedGreen = Color(0xFF228B22); // Forest Green

  // Surface Colors
  static const Color surfaceLight = Color(0xFFFAF6F0); // Very light cream
  static const Color surfaceMedium = Color(0xFFF0E6D2); // Light tan

  // Text Colors
  static const Color textPrimary = Color(0xFF2C1810); // Very dark brown
  static const Color textSecondary = Color(0xFF6B4423); // Medium brown
  static const Color textOnPrimary = Colors.white;

  // Accent Colors
  static const Color accent1 = Color(0xFFCD853F); // Peru
  static const Color accent2 = Color(0xFFA0522D); // Sienna
}

class CoffeeTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: CoffeeColors.primaryBrown,
        onPrimary: CoffeeColors.textOnPrimary,
        secondary: CoffeeColors.mocha,
        onSecondary: CoffeeColors.textOnPrimary,
        tertiary: CoffeeColors.accent1,
        onTertiary: CoffeeColors.textOnPrimary,
        error: Color(0xFFB00020),
        onError: CoffeeColors.textOnPrimary,
        surface: CoffeeColors.surfaceLight,
        onSurface: CoffeeColors.textPrimary,
        surfaceContainerHighest: CoffeeColors.surfaceMedium,
        onSurfaceVariant: CoffeeColors.textSecondary,
        outline: CoffeeColors.lightBrown,
        shadow: CoffeeColors.darkBrown,
        inverseSurface: CoffeeColors.darkBrown,
        onInverseSurface: CoffeeColors.cream,
        inversePrimary: CoffeeColors.lightBrown,
      ),

      // AppBar Theme
      appBarTheme: const AppBarTheme(
        backgroundColor: CoffeeColors.primaryBrown,
        foregroundColor: CoffeeColors.textOnPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          color: CoffeeColors.textOnPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),

      // Card Theme
      cardTheme: CardThemeData(
        color: CoffeeColors.surfaceLight,
        elevation: 8,
        shadowColor: CoffeeColors.darkBrown.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Button Themes
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: CoffeeColors.primaryBrown,
          foregroundColor: CoffeeColors.textOnPrimary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: CoffeeColors.cream,
          foregroundColor: CoffeeColors.primaryBrown,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: CoffeeColors.primaryBrown,
          side: const BorderSide(color: CoffeeColors.primaryBrown),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        ),
      ),

      // FloatingActionButton Theme
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: CoffeeColors.primaryBrown,
        foregroundColor: CoffeeColors.textOnPrimary,
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: CoffeeColors.surfaceLight,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: CoffeeColors.lightBrown),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: CoffeeColors.lightBrown),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: CoffeeColors.primaryBrown,
            width: 2,
          ),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        labelStyle: const TextStyle(color: CoffeeColors.textSecondary),
        hintStyle: TextStyle(
          color: CoffeeColors.textSecondary.withValues(alpha: 0.7),
        ),
      ),

      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: CoffeeColors.cream,
        selectedItemColor: CoffeeColors.primaryBrown,
        unselectedItemColor: CoffeeColors.textSecondary,
        elevation: 16,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),

      // Text Theme
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
        displayMedium: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 28,
          fontWeight: FontWeight.bold,
        ),
        displaySmall: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 24,
          fontWeight: FontWeight.w600,
        ),
        headlineLarge: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 22,
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        titleLarge: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
        titleSmall: TextStyle(
          color: CoffeeColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        bodyLarge: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 16,
          fontWeight: FontWeight.normal,
        ),
        bodyMedium: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.normal,
        ),
        bodySmall: TextStyle(
          color: CoffeeColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
        labelLarge: TextStyle(
          color: CoffeeColors.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        labelMedium: TextStyle(
          color: CoffeeColors.textSecondary,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
        labelSmall: TextStyle(
          color: CoffeeColors.textSecondary,
          fontSize: 10,
          fontWeight: FontWeight.w500,
        ),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: CoffeeColors.surfaceMedium,
        labelStyle: const TextStyle(color: CoffeeColors.textPrimary),
        secondaryLabelStyle: const TextStyle(color: CoffeeColors.textOnPrimary),
        selectedColor: CoffeeColors.primaryBrown,
        disabledColor: CoffeeColors.lightBrown.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),

      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: CoffeeColors.primaryBrown,
      ),

      // Divider Theme
      dividerTheme: DividerThemeData(
        color: CoffeeColors.lightBrown.withValues(alpha: 0.5),
        thickness: 1,
      ),
    );
  }

  // Status Color Extensions
  static Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return CoffeeColors.pendingOrange;
      case 'completed':
        return CoffeeColors.completedGreen;
      default:
        return CoffeeColors.textSecondary;
    }
  }

  static Color getStatusBackgroundColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return CoffeeColors.pendingOrange.withValues(alpha: 0.1);
      case 'completed':
        return CoffeeColors.completedGreen.withValues(alpha: 0.1);
      default:
        return CoffeeColors.surfaceMedium;
    }
  }
}
