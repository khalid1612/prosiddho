import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/style/style_export.dart';

class Buttons {
  //sign in button
  static Widget signInButton(
    Color background,
    IconData icon,
    Color iconColor,
    String text, {
    TextStyle textStyle,
  }) =>
      Container(
        width: Get.width * .7,
        height: 50,
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            FaIcon(
              icon,
              color: iconColor,
            ),
            Text(
              text,
              style: textStyle ??
                  TextStyle(
                    fontSize: 18,
                  ),
            ),
          ],
        ),
      );

  //guest button
  static Widget guestButton() => Container(
        width: Get.width * .6,
        margin: EdgeInsets.only(top: 20),
        child: Center(
          child: Text(
            "Continue as Guest",
            style: TextStyle(
              color: Colors.white,
              fontSize: 15,
            ),
          ),
        ),
      );

  //rounded icon button
  static Widget roundedIconBtn(
    IconData icon,
    Function press, {
    bool showShadow = false,
    Color bgColor,
    Color iconColor = Colors.black,
    double btnSize = 28.0,
    double iconSize = 15.0,
  }) =>
      Container(
        height: Util.getProportionateScreenWidth(btnSize),
        width: Util.getProportionateScreenWidth(btnSize),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          boxShadow: [
            if (showShadow)
              BoxShadow(
                offset: Offset(0, 6),
                blurRadius: 10,
                color: Color(0xFFB0B0B0).withOpacity(0.2),
              ),
          ],
        ),
        child: FlatButton(
          padding: EdgeInsets.zero,
          color: bgColor ?? Colors.black.withOpacity(.1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: press,
          child: Center(
            child: Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
          ),
        ),
      );

  static normalButton({
    @required String text,
    @required Function onTap,
    EdgeInsets padding,
  }) =>
      GestureDetector(
        onTap: onTap,
        child: Container(
          padding: padding ??
              EdgeInsets.symmetric(
                vertical: Style.margin / 2.5,
                horizontal: Style.margin,
              ),
          decoration: BoxDecoration(
            color: ColorPalette.primary,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: ColorPalette.textLight,
                fontSize: 16,
              ),
            ),
          ),
        ),
      );

  static iconButtonWithCounter({
    @required iconData,
    numOfitem = 0,
    @required press,
    bgColor,
    double size = 45,
  }) =>
      InkWell(
        borderRadius: BorderRadius.circular(100),
        onTap: press,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              padding: EdgeInsets.all(
                Util.getProportionateScreenWidth((10 * size) / 45),
              ),
              margin: EdgeInsets.only(
                left: Util.getProportionateScreenWidth((5 * size) / 45),
              ),
              height: Util.getProportionateScreenWidth(size),
              width: Util.getProportionateScreenWidth(size),
              decoration: BoxDecoration(
                color: bgColor ?? ColorPalette.bg.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: (20 * size) / 45,
                color: numOfitem == 0
                    ? ColorPalette.primary
                    : ColorPalette.primaryPurple,
              ),
            ),
            if (numOfitem != 0)
              Positioned(
                top: -3,
                right: 0,
                child: Container(
                  height: Util.getProportionateScreenWidth(
                      numOfitem < 10 ? 16 : 20),
                  width: Util.getProportionateScreenWidth(
                      numOfitem < 10 ? 16 : 20),
                  decoration: BoxDecoration(
                    color: ColorPalette.primaryPurple,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1.5, color: Colors.white),
                  ),
                  child: Center(
                    child: Text(
                      "$numOfitem",
                      style: TextStyle(
                        fontSize: Util.getProportionateScreenWidth(10),
                        height: 1,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
          ],
        ),
      );
}
