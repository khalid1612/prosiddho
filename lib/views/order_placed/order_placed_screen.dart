import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:get/get.dart';

class OrderPlacedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.until((route) => Get.currentRoute == '/DashboardScreen');
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorPalette.primary,
          title: Text("Order Confirmation"),
          centerTitle: true,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.thumbsUp,
                size: 100,
                color: Colors.green.withOpacity(.5),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Text(
                    "Thank you",
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.green.withOpacity(.5),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigation(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Buttons.normalButton(
                text: "FINISH",
                padding: EdgeInsets.all(20),
                onTap: () {
                  Get.until((route) => Get.currentRoute == '/DashboardScreen');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
