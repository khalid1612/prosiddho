import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/style/color_palette.dart';

class ProfileUserBasic extends StatelessWidget {
  final UserController _userController = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Style.marginBase,
      child: Container(
        padding: Style.marginBase,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //image
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  ColorPalette.customShadow(
                    blurRadius: 3.0,
                    color: Colors.black38,
                    dy: 4.0,
                    spreadRadius: 0,
                  ),
                ],
              ),
              child: ImageLoading.cachedNetworkImage(
                _userController.userModel.gamil.photoURL,
                radius: 50,
              ),
            ),

            SizedBox(width: 30),

            //name, email, phone
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _userController.userModel.name.capitalize,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  _userController.userModel.gamil.email,
                  style: TextStyle(
                    color: ColorPalette.secondary,
                  ),
                ),
                SizedBox(height: 10),

                //phone
                if (_userController.userModel.phone != null)
                  Text(_userController.userModel.phone.toString()),

                //edit
                Container(
                  height: 25,
                  width: 70,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      "Edit",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
