import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/style/style_export.dart';

class MenuHeader extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        width: 200,
        margin: Style.marginAppbar,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            Container(
              height: 65,
              width: 65,
              margin: EdgeInsets.only(top: 50),
              decoration: BoxDecoration(
                borderRadius: Style.borderRadius * 2,
                color: ColorPalette.tertiary.withOpacity(.1),
                image: DecorationImage(
                  image: NetworkImage(_userController.userModel.gamil.photoURL),
                ),
              ),
            ),

            SizedBox(height: 20),

            //greating
            Text(
              "Hey",
              style: TextStyle(
                fontSize: 25,
                color: Colors.white70,
              ),
            ),

            //name
            Text(
              _userController.userModel.name.capitalize,
              style: TextStyle(
                fontSize: 23,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
