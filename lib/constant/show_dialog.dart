import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/signin_controller.dart';
import 'package:prosiddho/enum/sign_in_method.dart';

class ShowDialog {
  static void guestUserRestrictedFeature(dynamic pageName) {
    final SigninController _signInController = Get.find<SigninController>();

    if (_signInController.signInMethod == SignInMethod.Guest) {
      Get.defaultDialog(
        title: "Sign in to continue",
        middleText: "Guest user not allowed to access it",
        onConfirm: () => print("ok"),
        confirmTextColor: Colors.black,
      );
    } else {
      Get.to(pageName);
    }
  }
}
