import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

mixin AppColors {
  static const Color beige = Color(0xFFD5B590);
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
  static const Color darkGrey = Color.fromRGBO(61, 61, 61, 1);
  static const Color grey = Color(0xFFE5E5E5);
  static const Color lightGraySurface = Color(0xFFF7F7F7);
  static const Color offWhite = Color(0xFFF8F8F8);
  static const Color softBeige = Color(0xFFF4EDE3);

  static const Color primary = black;
  static const Color secondary = darkGrey;
  static const Color background = offWhite;
  static const Color surface = lightGraySurface;
  static const Color onPrimary = white;
  static const Color onSecondary = white;
  static const Color onBackground = darkGrey;
  static const Color onSurface = black;
  static const Color accent = beige;
}

mixin AppTheme {
  static ThemeData createTheme() {
    ColorScheme appColorScheme = const ColorScheme(
      primary: AppColors.primary,
      secondary: AppColors.accent,
      surface: AppColors.surface,
      background: AppColors.background,
      error: Colors.red,
      onPrimary: AppColors.onPrimary,
      onSecondary: AppColors.onSecondary,
      onSurface: AppColors.onSurface,
      onBackground: AppColors.onBackground,
      onError: AppColors.onPrimary,
      brightness: Brightness.light,
    );

    final TextTheme appTextTheme = TextTheme(
      displayLarge: GoogleFonts.playfairDisplay(
        fontSize: 64.0,
        fontWeight: FontWeight.bold,
        color: AppColors.onBackground,
      ),
      displayMedium: GoogleFonts.playfairDisplay(
        fontSize: 48.0,
        fontWeight: FontWeight.bold,
        color: AppColors.onBackground,
      ),
      displaySmall: GoogleFonts.playfairDisplay(
        fontSize: 36.0,
        fontWeight: FontWeight.w600,
        color: AppColors.onBackground,
      ),
      headlineLarge: GoogleFonts.merriweather(
        fontSize: 28.0,
        fontWeight: FontWeight.w500,
        color: AppColors.onBackground,
      ),
      headlineMedium: GoogleFonts.merriweather(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: AppColors.onBackground,
      ),
      headlineSmall: GoogleFonts.merriweather(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: AppColors.onBackground,
      ),
      titleLarge: GoogleFonts.playfairDisplay(
        fontSize: 22.0,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurface,
      ),
      titleMedium: GoogleFonts.playfairDisplay(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        color: AppColors.onSurface,
      ),
      titleSmall: GoogleFonts.merriweather(
        fontSize: 18.0,
        fontWeight: FontWeight.w400,
        color: AppColors.onSurface,
      ),
      bodyLarge: GoogleFonts.lora(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: AppColors.onSurface,
      ),
      bodyMedium: GoogleFonts.lora(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: AppColors.secondary,
      ),
      bodySmall: GoogleFonts.lora(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        height: 1.6,
        color: AppColors.secondary,
      ),
      labelLarge: GoogleFonts.merriweather(
        fontSize: 14.0,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),
      labelMedium: GoogleFonts.merriweather(
        fontSize: 12.0,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),
      labelSmall: GoogleFonts.merriweather(
        fontSize: 10.0,
        fontWeight: FontWeight.bold,
        color: AppColors.onPrimary,
      ),
    );

    return ThemeData(
      colorScheme: appColorScheme,
      textTheme: appTextTheme,
      primaryColor: AppColors.primary,
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: AppColors.background,
        iconTheme: const IconThemeData(color: AppColors.primary),
        toolbarTextStyle: appTextTheme.titleMedium,
        titleTextStyle: GoogleFonts.playfairDisplay(
          fontSize: 20.0,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
        ),
      ),
      buttonTheme: ButtonThemeData(
        buttonColor: AppColors.primary,
        textTheme: ButtonTextTheme.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      cardTheme: const CardTheme(
        color: AppColors.surface,
        elevation: 2,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          textStyle: appTextTheme.bodyMedium,
        ),
      ),
    );
  }
}