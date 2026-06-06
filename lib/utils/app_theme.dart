import 'package:flutter/material.dart';

class AppColors {
  // Background colors
  static const Color backgroundColor = Color(0xFF000000);
  static const Color backgroundLightingColor = Color(0xFF0080FF);

  // App main colors
  static const Color primaryColor = Color(0xFF111827);
  static const Color secondaryColor = Color(0xFF1E293B);

  // App navbar colors
  static const Color selectedItemColor = Color(0xFFFFFFFF);
  static const Color unselectedItemColor = Colors.white54;

  // Text colors
  static const Color textPrimaryColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFD9D9D9);

  // Value colors
  static const Color increasedValueColor = Color(0xFF34C759);
  static const Color decreasedValueColor = Color(0xFFFF3B30);

  static BoxDecoration appBackground({
    Alignment center = Alignment.center,
  }) {
    return BoxDecoration(
      gradient: RadialGradient(
        center: center,
        radius: 1.2,
        colors: [
          Color(0xFF0080FF),
          Color(0xFF021B3A),
          Color(0xFF000000),
        ],
      ),
    );
  }

  static BoxDecoration glassCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        Color.fromRGBO(255, 255, 255, 0.08),
        Color.fromRGBO(255, 255, 255, 0.03),
      ],
    ),
    border: Border.all(
      color: Color.fromRGBO(255, 255, 255, 0.15),
      width: 1,
    ),
    boxShadow: [
      BoxShadow(
        color: Color.fromRGBO(255, 255, 255, 0.04),
        blurRadius: 20,
        spreadRadius: 1,
      ),
    ],
  );
}