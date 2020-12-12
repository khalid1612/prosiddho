import 'package:flutter/material.dart';
import 'style.dart';
import 'package:prosiddho/constant/assets.dart';

ThemeData themeData() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: Assets.fontFamily,
    appBarTheme: appBarTheme(),
    textTheme: textTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );
}

AppBarTheme appBarTheme() {
  return AppBarTheme(
    color: Colors.white,
    elevation: 0,
    brightness: Brightness.light,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
  );
}

TextTheme textTheme() {
  return TextTheme(
    bodyText1: Style.body1,
    bodyText2: Style.body2,
  );
}
