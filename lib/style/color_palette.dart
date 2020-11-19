import 'package:flutter/material.dart';

class ColorPalette {
  static const Color primaryRed = Color(0xFFFF2D55);
  static const Color primaryPurple = Color(0xFF25408F);
  static const Color primaryAmber = Color(0xFFF2AE1B);

  static const Color secondaryDeep = Color(0xFF1E3354);
  static const Color secondaryMid = Color(0xFF7F8E9D);
  static const Color secondaryLight = Color(0xFFC7CAD9);

  static const Color primaryMain = primaryAmber;
  static const Color secondaryMain = primaryRed;

  static const Color text = Color(0xFF242A37);
  static const Color textLight = Color(0xFFF1F2F6);

  static const Color scaffold = Color(0xFFFFFFFF);
  static const Color scaffold2 = Color(0xFFF5F5F5);

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
