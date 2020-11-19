import 'package:flutter/material.dart';
import 'package:prosiddho/constant/values.dart';
import 'package:prosiddho/style/color_palette.dart';

class Style {
  //margin
  static const EdgeInsets marginHorizontally = const EdgeInsets.symmetric(
    horizontal: Values.margin,
  );

  static const EdgeInsets marginVertically = const EdgeInsets.symmetric(
    vertical: Values.margin,
  );

  static const EdgeInsets marginBase = const EdgeInsets.all(Values.margin);

  //padding
  static const EdgeInsets paddingHorizontally = marginHorizontally;
  static const EdgeInsets paddingVertically = marginVertically;
  static const EdgeInsets paddingBase = marginBase;

  static BorderRadius borderRadius = BorderRadius.circular(12);

  static EdgeInsets marginHorizontalListview(int length, int index) {
    return index == 0
        ? EdgeInsets.only(
            left: Values.margin,
            right: Values.margin / 2,
          )
        : index == length - 1
            ? EdgeInsets.only(right: Values.margin)
            : EdgeInsets.only(right: Values.margin / 2);
  }

  //************text style*******/

  //heading1
  static const TextStyle heading1 = TextStyle(
    fontSize: Values.fontSizeHeading1,
    color: ColorPalette.text,
    fontWeight: FontWeight.bold,
  );

  //heading2
  static const TextStyle heading2 = TextStyle(
    fontSize: Values.fontSizeHeading2,
    color: ColorPalette.text,
    fontWeight: FontWeight.w600,
  );

  //heading3
  static const TextStyle heading3 = TextStyle(
    fontSize: Values.fontSizeHeading3,
    color: ColorPalette.text,
    fontWeight: FontWeight.bold,
  );

  //heading4
  static const TextStyle heading4 = TextStyle(
    fontSize: Values.fontSizeHeading4,
    color: ColorPalette.text,
    fontWeight: FontWeight.w600,
  );

  //body1
  static const TextStyle body1 = TextStyle(
    fontSize: Values.fontSizeBody1,
    color: ColorPalette.text,
    fontWeight: FontWeight.normal,
  );

  //body2
  static const TextStyle body2 = TextStyle(
    fontSize: Values.fontSizeBody2,
    color: ColorPalette.text,
    fontWeight: FontWeight.normal,
  );

  //************text style*******/

}
