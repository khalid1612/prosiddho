import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class CustomDialog {
  static serverMaintenance() => Get.defaultDialog(
        title: "Server Mainterance",
        textConfirm: "I Understand",
        confirmTextColor: Colors.white,
        barrierDismissible: false,
        onConfirm: () => exit(0),
        content: Column(
          children: [
            Text(
              "App under Mainterance. We will back soon. Downtime approximately 2 hours.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
}
