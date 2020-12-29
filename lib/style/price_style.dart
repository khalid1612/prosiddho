import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/constant/constant_export.dart';

class PriceStyle {
  static Widget priceStyle({
    @required double regular,
    @required double offer,
    double fontSize,
    Color fontColor,
  }) =>
      RichText(
        text: TextSpan(
          text: Values.tkSign + regular.toStringAsFixed(0),
          style: TextStyle(
            color: offer == 0
                ? ColorPalette.text.withOpacity(.7)
                : ColorPalette.textLight,
            fontSize: offer != 0 ? 16 : fontSize ?? 16,
            decoration:
                offer == 0 ? TextDecoration.none : TextDecoration.lineThrough,
          ),
          children: <TextSpan>[
            if (offer != 0)
              TextSpan(
                text: "  " + Values.tkSign + offer.toStringAsFixed(0),
                style: TextStyle(
                  color: fontColor ?? ColorPalette.text.withOpacity(.7),
                  fontSize: fontSize ?? 16.0,
                  decoration: TextDecoration.none,
                ),
              ),
          ],
        ),
      );
}
