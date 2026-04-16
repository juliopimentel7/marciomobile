import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF16A34A); // green-600
  static const Color primaryDark = Color(0xFF15803D); // green-700
  static const Color primaryLight = Color(0xFFDCFCE7); // green-50
  static const Color primaryText = Color(0xFF166534); // green-900
  static const Color background = Color(0xFFF9FAFB); // gray-50
  static const Color surface = Colors.white;
  static const Color border = Color(0xFFE5E7EB); // gray-200
  static const Color textPrimary = Color(0xFF1F2937); // gray-800
  static const Color textSecondary = Color(0xFF6B7280); // gray-500
  static const Color textMuted = Color(0xFF9CA3AF); // gray-400

  static ThemeData get theme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primary,
          primary: primary,
          surface: surface,
        ),
        scaffoldBackgroundColor: background,
        appBarTheme: const AppBarTheme(
          backgroundColor: surface,
          foregroundColor: textPrimary,
          elevation: 0,
          scrolledUnderElevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
        ),
        cardTheme: CardThemeData(
          color: surface,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: const BorderSide(color: border),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primary,
            foregroundColor: Colors.white,
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: textPrimary,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: textPrimary,
          ),
          bodyMedium: TextStyle(color: textPrimary),
          bodySmall: TextStyle(color: textSecondary),
        ),
        dividerTheme: const DividerThemeData(
          color: border,
          thickness: 1,
        ),
      );
}
