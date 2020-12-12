import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prosiddho/style/style.dart';

class Buttons {
  //sign in button
  static Widget signInButton(
    Color background,
    IconData icon,
    Color iconColor,
    String text, {
    TextStyle textStyle,
  }) {
    return Container(
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
  }

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
}
