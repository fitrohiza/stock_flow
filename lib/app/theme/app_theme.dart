import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:stock_flow/app/theme/app_text_theme.dart';

ThemeData appTheme(BuildContext context, Brightness brightness) {
  final colorScheme = ColorScheme.fromSeed(
    brightness: brightness,
    seedColor: const Color(0xFFFF6D00),
    primary: const Color(0xFFFF6D00),
    secondary: const Color(0xFFFFAB40),
    tertiary: const Color(0xFF00C48C),
    surface: brightness == Brightness.light
        ? const Color(0xFFFFF8F3)
        : const Color(0xFF1A1A1A),
  );

  return ThemeData(
    fontFamily: GoogleFonts.openSans().fontFamily,
    colorScheme: colorScheme,
    scaffoldBackgroundColor: Colors.white,

    appBarTheme: AppBarTheme(
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: Colors.white,
      foregroundColor: colorScheme.onSurface,
      titleTextStyle: appTextStyle(
        context,
      ).titleMedium?.copyWith(color: colorScheme.onSurface),
    ),

    actionIconTheme: ActionIconThemeData(
      backButtonIconBuilder: (_) =>
          const Icon(Icons.arrow_back_ios_new_rounded),
    ),

    chipTheme: ChipThemeData(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      side: BorderSide.none,
    ),

    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: colorScheme.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(16),
        textStyle: appTextStyle(context).titleSmall,
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: colorScheme.primary,
      foregroundColor: Colors.white,
      shape: const CircleBorder(),
    ),

    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: colorScheme.primary,
        textStyle: appTextStyle(
          context,
        ).bodyLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: colorScheme.onPrimary,
      border: OutlineInputBorder(
        borderSide: BorderSide.none,
        borderRadius: BorderRadius.circular(24),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.primary),
        borderRadius: BorderRadius.circular(24),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
        borderRadius: BorderRadius.circular(24),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: colorScheme.error),
        borderRadius: BorderRadius.circular(24),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      hintStyle: appTextStyle(
        context,
      ).bodyLarge?.copyWith(color: colorScheme.outlineVariant),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: colorScheme.primary),
        foregroundColor: colorScheme.primary,
        padding: const EdgeInsets.all(16),
        textStyle: appTextStyle(context).titleSmall,
      ),
    ),
  );
}
