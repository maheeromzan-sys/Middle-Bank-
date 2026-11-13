import 'package:flutter/material.dart';

class Brand {
  static const navy = Color(0xFF063B78);
  static const green = Color(0xFF009B63);
  static const white = Color(0xFFFFFFFF);
  static const lightBlue = Color(0xFFEAF3FF);

  // Supporting neutrals
  static const ink = Color(0xFF12263F);
  static const muted = Color(0xFF6B7C93);
  static const border = Color(0xFFD5E2F2);
  static const amber = Color(0xFFE59A00);
  static const danger = Color(0xFFD64545);

  static const navyGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF042A57), navy, Color(0xFF0B5AA8)],
  );
}

ThemeData buildTheme() {
  final scheme = ColorScheme.fromSeed(
    seedColor: Brand.navy,
    primary: Brand.navy,
    secondary: Brand.green,
    surface: Brand.white,
  );
  return ThemeData(
    useMaterial3: true,
    colorScheme: scheme,
    scaffoldBackgroundColor: Brand.lightBlue,
    textTheme: ThemeData.light().textTheme.apply(
          bodyColor: Brand.ink,
          displayColor: Brand.ink,
        ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Brand.navy,
      foregroundColor: Brand.white,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: Brand.white,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Brand.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Brand.border),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Brand.border),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Brand.navy, width: 1.6),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Brand.danger),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Brand.danger, width: 1.6),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: Brand.white,
      indicatorColor: Brand.lightBlue,
      labelTextStyle: WidgetStateProperty.resolveWith(
        (s) => TextStyle(
          fontSize: 12,
          fontWeight: s.contains(WidgetState.selected)
              ? FontWeight.w700
              : FontWeight.w500,
          color: s.contains(WidgetState.selected) ? Brand.navy : Brand.muted,
        ),
      ),
      iconTheme: WidgetStateProperty.resolveWith(
        (s) => IconThemeData(
          color: s.contains(WidgetState.selected) ? Brand.navy : Brand.muted,
        ),
      ),
    ),
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: Brand.navy,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
    ),
  );
}
