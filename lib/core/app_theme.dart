import 'package:flutter/material.dart';

class AppTheme {
  // ============== DARK MODE COLORS (Instagram Dark Mode Inspired) ==============
  // Primary backgrounds - Instagram dark palette
  static const Color darkBlueBG = Color(0xFF000000); // Pure black background
  static const Color darkCardBg = Color(0xFF1A1A1A); // Very dark gray cards
  static const Color darkSurfaceLight = Color(
    0xFF262626,
  ); // Lighter surface for depth

  // Accent colors
  static const Color vibrantBlue = Color(0xFF0095F6); // Instagram blue
  static const Color vibrantGreen = Color(0xFF31A24C); // Instagram green
  static const Color vibrantPurple = Color(0xFF9C27B0); // Purple accent
  static const Color vibrantOrange = Color(0xFFFF6B35); // Orange accent
  static const Color vibrantPink = Color(0xFFFF1744); // Pink accent

  // Text colors - dark mode (Instagram style)
  static const Color darkTextPrimary = Color(0xFFFAFAFA); // Almost white
  static const Color darkTextSecondary = Color(0xFFA8A8A8); // Medium gray
  static const Color darkTextTertiary = Color(0xFF626262); // Darker gray

  // ============== LIGHT MODE COLORS ==============
  // Primary backgrounds
  static const Color lightBG = Color(0xFFFAFAFA);
  static const Color lightCardBg = Color(0xFFFFFFFF);
  static const Color lightSurfaceLight = Color(0xFFF5F5F5);

  // Text colors - light mode
  static const Color lightTextPrimary = Color(0xFF1A1A1A);
  static const Color lightTextSecondary = Color(0xFF616161);
  static const Color lightTextTertiary = Color(0xFF9E9E9E);

  // ============== SEMANTIC COLORS ==============
  static const Color successGreen = Color(0xFF4CAF50);
  static const Color errorRed = Color(0xFFF44336);
  static const Color warningOrange = Color(0xFFFFC107);
  static const Color infoBlue = Color(0xFF2196F3);

  // ============== DARK MODE THEME ==============
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: darkBlueBG,
      primaryColor: vibrantBlue,

      colorScheme: const ColorScheme.dark(
        primary: vibrantBlue,
        secondary: vibrantGreen,
        tertiary: vibrantPurple,
        surface: darkCardBg,
        surfaceContainer: darkSurfaceLight,
        outline: darkTextTertiary,
      ),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: darkTextPrimary,
          letterSpacing: 0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: darkTextPrimary,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: darkTextSecondary,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: darkTextTertiary,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: darkTextSecondary,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: darkTextTertiary,
          letterSpacing: 0.5,
        ),
      ),

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: darkCardBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: darkTextPrimary,
        ),
        iconTheme: IconThemeData(color: darkTextPrimary),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: darkCardBg,
        selectedItemColor: vibrantBlue,
        unselectedItemColor: darkTextTertiary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // Card
      cardTheme: CardThemeData(
        color: darkCardBg,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: vibrantBlue,
          foregroundColor: darkTextPrimary,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: vibrantBlue,
          side: const BorderSide(color: vibrantBlue, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: vibrantBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: darkSurfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkTextTertiary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: darkTextTertiary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: vibrantBlue, width: 2),
        ),
        hintStyle: const TextStyle(color: darkTextTertiary, fontSize: 14),
        labelStyle: const TextStyle(color: darkTextSecondary, fontSize: 14),
        prefixIconColor: darkTextSecondary,
        suffixIconColor: darkTextSecondary,
      ),

      // FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: vibrantBlue,
        foregroundColor: darkTextPrimary,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: darkSurfaceLight,
        selectedColor: vibrantBlue,
        labelStyle: const TextStyle(color: darkTextPrimary, fontSize: 14),
        deleteIconColor: darkTextSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: darkTextTertiary,
        thickness: 1,
        space: 16,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: darkCardBg,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // ============== LIGHT MODE THEME ==============
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: lightBG,
      primaryColor: vibrantBlue,

      colorScheme: const ColorScheme.light(
        primary: vibrantBlue,
        secondary: vibrantGreen,
        tertiary: vibrantPurple,
        surface: lightCardBg,
        surfaceContainer: lightSurfaceLight,
        outline: lightTextTertiary,
      ),

      // Typography
      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
          letterSpacing: -0.5,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
        ),
        displaySmall: TextStyle(
          fontSize: 36,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
        ),
        headlineLarge: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
          color: lightTextPrimary,
          letterSpacing: 0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
        ),
        headlineSmall: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w500,
          color: lightTextPrimary,
        ),
        titleMedium: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
          color: lightTextPrimary,
        ),
        titleSmall: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: lightTextPrimary,
          letterSpacing: 0.1,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
          color: lightTextPrimary,
          letterSpacing: 0.5,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w400,
          color: lightTextSecondary,
          letterSpacing: 0.25,
        ),
        bodySmall: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w400,
          color: lightTextTertiary,
          letterSpacing: 0.4,
        ),
        labelLarge: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
          letterSpacing: 0.1,
        ),
        labelMedium: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: lightTextSecondary,
          letterSpacing: 0.5,
        ),
        labelSmall: TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w500,
          color: lightTextTertiary,
          letterSpacing: 0.5,
        ),
      ),

      // App Bar
      appBarTheme: const AppBarTheme(
        backgroundColor: lightCardBg,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: lightTextPrimary,
        ),
        iconTheme: IconThemeData(color: lightTextPrimary),
      ),

      // Bottom Navigation
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: lightCardBg,
        selectedItemColor: vibrantBlue,
        unselectedItemColor: lightTextTertiary,
        elevation: 0,
        type: BottomNavigationBarType.fixed,
      ),

      // Card
      cardTheme: CardThemeData(
        color: lightCardBg,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),

      // Buttons
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: vibrantBlue,
          foregroundColor: Colors.white,
          elevation: 2,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: vibrantBlue,
          side: const BorderSide(color: vibrantBlue, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        ),
      ),

      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: vibrantBlue,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        ),
      ),

      // Input fields
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: lightSurfaceLight,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightTextTertiary, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: lightTextTertiary, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: vibrantBlue, width: 2),
        ),
        hintStyle: const TextStyle(color: lightTextTertiary, fontSize: 14),
        labelStyle: const TextStyle(color: lightTextSecondary, fontSize: 14),
        prefixIconColor: lightTextSecondary,
        suffixIconColor: lightTextSecondary,
      ),

      // FAB
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: vibrantBlue,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),

      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: lightSurfaceLight,
        selectedColor: vibrantBlue,
        labelStyle: const TextStyle(color: lightTextPrimary, fontSize: 14),
        deleteIconColor: lightTextSecondary,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),

      // Divider
      dividerTheme: const DividerThemeData(
        color: lightTextTertiary,
        thickness: 1,
        space: 16,
      ),

      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: lightCardBg,
        elevation: 4,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  // ============== LEGACY SUPPORT ==============
  // Keep old properties for backward compatibility
  static ThemeData get themeData => darkTheme;

  // Backward compatibility color getters
  static const Color cardBg = darkCardBg;
  static const Color textPrimary = darkTextPrimary;
  static const Color textSecondary = darkTextSecondary;
}
