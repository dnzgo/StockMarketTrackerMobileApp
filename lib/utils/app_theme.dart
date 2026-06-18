import 'package:flutter/material.dart';

class AppColors {
  // Background colors
  static const Color backgroundColor = Color(0xFF000000);
  static const Color backgroundLightingColor = Color(0xFF0080FF);
  static const Color backgroundGradientMiddle = Color(0xFF021B3A);

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

  // Watchlist icon color
  static const Color watchlistColor = Colors.amber;

  // Glass colors
  static const Color glassPrimary =
  Color.fromRGBO(255, 255, 255, 0.08);

  static const Color glassSecondary =
  Color.fromRGBO(255, 255, 255, 0.03);

  static const Color glassButtonPrimary =
  Color.fromRGBO(255, 255, 255, 0.12);

  static const Color glassButtonSecondary =
  Color.fromRGBO(255, 255, 255, 0.05);

  static const Color glassTogglePrimary =
  Color.fromRGBO(255, 255, 255, 0.16);

  static const Color glassToggleSecondary =
  Color.fromRGBO(255, 255, 255, 0.08);

  static const Color glassBorder =
  Color.fromRGBO(255, 255, 255, 0.15);

  static const Color glassButtonBorder =
  Color.fromRGBO(255, 255, 255, 0.20);

  static const Color glassShadow =
  Color.fromRGBO(255, 255, 255, 0.04);

  static const Color glassToggleShadow =
  Color.fromRGBO(255, 255, 255, 0.08);

  // Selected state colors
  static const Color selectedGlassBorder = Colors.white;
  static const Color selectedGlassShadow = Colors.white10;

  // Toggle colors
  static const Color toggleKnobColor = Colors.white;

  static BoxDecoration appBackground({
    Alignment center = Alignment.center,
  }) {
    return BoxDecoration(
      gradient: RadialGradient(
        center: center,
        radius: 1.2,
        colors: const [
          backgroundLightingColor,
          backgroundGradientMiddle,
          backgroundColor,
        ],
      ),
    );
  }

  static BoxDecoration glassCardDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        glassPrimary,
        glassSecondary,
      ],
    ),
    border: Border.all(
      color: glassBorder,
      width: 1,
    ),
    boxShadow: const [
      BoxShadow(
        color: glassShadow,
        blurRadius: 20,
        spreadRadius: 1,
      ),
    ],
  );

  static BoxDecoration glassButtonDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(32),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        glassButtonPrimary,
        glassButtonSecondary,
      ],
    ),
    border: Border.all(
      color: glassButtonBorder,
      width: 1,
    ),
  );

  static BoxDecoration selectedGlassCardDecoration =
  BoxDecoration(
    borderRadius: BorderRadius.circular(24),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        glassPrimary,
        glassSecondary,
      ],
    ),
    border: Border.all(
      color: selectedGlassBorder,
      width: 1.5,
    ),
    boxShadow: const [
      BoxShadow(
        color: selectedGlassShadow,
        blurRadius: 10,
        spreadRadius: 0,
      ),
    ],
  );

  static BoxDecoration glassToggleDecoration =
  BoxDecoration(
    borderRadius: BorderRadius.circular(32),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        glassButtonPrimary,
        glassButtonSecondary,
      ],
    ),
    border: Border.all(
      color: glassButtonBorder,
      width: 1,
    ),
  );

  static BoxDecoration selectedGlassToggleDecoration =
  BoxDecoration(
    borderRadius: BorderRadius.circular(32),
    gradient: const LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        glassTogglePrimary,
        glassToggleSecondary,
      ],
    ),
    border: Border.all(
      color: selectedGlassBorder,
      width: 1.2,
    ),
    boxShadow: const [
      BoxShadow(
        color: glassToggleShadow,
        blurRadius: 4,
        spreadRadius: 0,
      ),
    ],
  );
}