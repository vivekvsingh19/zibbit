import 'package:flutter/material.dart';

class AppTheme {
  // Colors
  static const Color darkBlueBG = Color(0xFF1A1B2E);
  static const Color vibrantBlue = Color(0xFF2962FF);
  static const Color vibrantGreen = Color(0xFF00E676);
  static const Color cardBg = Color(0xFF2D2E45);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xFFB8B8B8);

  // Typography
  static const TextTheme textTheme = TextTheme(
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.bold,
      color: textPrimary,
    ),
    titleLarge: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w600,
      color: textPrimary,
    ),
    bodyLarge: TextStyle(fontSize: 16, color: textPrimary),
    bodyMedium: TextStyle(fontSize: 14, color: textSecondary),
  );

  // Theme Data
  static ThemeData themeData = ThemeData(
    scaffoldBackgroundColor: darkBlueBG,
    primaryColor: vibrantBlue,
    colorScheme: const ColorScheme.dark(
      primary: vibrantBlue,
      secondary: vibrantGreen,
      surface: darkBlueBG,
    ),
    textTheme: textTheme,
    appBarTheme: const AppBarTheme(backgroundColor: darkBlueBG, elevation: 0),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: cardBg,
      selectedItemColor: vibrantBlue,
      unselectedItemColor: textSecondary,
    ),
  );
}
