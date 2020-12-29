import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primary = Color(0xFF333333);
  static const Color secondary = Color(0xFFB2B2B2);
  static const Color tertiary = Color(0xFFF8D9E0);

  static const Color primaryRed = Color(0xFFFF2D55);
  static const Color primaryPurple = Color(0xFF25408F);
  // static const Color primaryAmber = Color(0xFFF2AE1B);

  // static const Color secondaryDeep = Color(0xFF1E3354);
  // static const Color secondaryMid = Color(0xFF7F8E9D);
  // static const Color secondaryLight = Color(0xFFC7CAD9);

  // static const Color primaryMain = primaryAmber;
  // static const Color secondaryMain = primaryRed;

  static const Color text = primary;
  static const Color textLight = secondary;

  // static const Color scaffold = Color(0xFFFFFFFF);

  static const bg = Color(0xFF979797);

  static const LinearGradient colorSplash = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      Color(0xFF667EEA),
      Color(0xFF64B6FF),
    ],
  );

  static const LinearGradient colorButton = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [
      Color(0xFF667EEA),
      Color(0xFF64B6FF),
    ],
  );

  static BoxShadow shadow = BoxShadow(
    blurRadius: 4.0,
    color: Colors.black26,
    offset: Offset(0.0, 4.0),
  );

  static BoxShadow customShadow({
    double blurRadius = 40.0,
    double dx = 0.0,
    double dy = 20.0,
    double spreadRadius = 1.0,
    Color color,
  }) =>
      BoxShadow(
        blurRadius: blurRadius,
        color: color ?? Color(0xFF12153D).withOpacity(0.1),
        offset: Offset(dx, dy),
        spreadRadius: spreadRadius,
      );
}
