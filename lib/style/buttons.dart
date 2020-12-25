import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';

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
    Color iconColor = Colors.white,
    double size = 40.0,
  }) =>
      Container(
        height: Util.getProportionateScreenWidth(size),
        width: Util.getProportionateScreenWidth(size),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: bgColor ?? Colors.black.withOpacity(.1),
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
          color: iconColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          onPressed: press,
          child: Icon(
            icon,
            size: size,
          ),
        ),
      );
}
