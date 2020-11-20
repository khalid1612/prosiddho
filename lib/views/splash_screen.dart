import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/admin_controller.dart';
import 'package:prosiddho/controller/signin_controller.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/views/sign_in_screen.dart';

class SplashScreen extends StatelessWidget {
  final SigninController _signInController = Get.put(SigninController());
  final AdminController _adminController = Get.put(AdminController());
  final UserController _userController = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    //start a user stream
    //bacause if user change his name or phone or address or
    //user used a  free delivery or earn points or
    //make an order then it will update automatically
    void _tryToSignIn() async {
      await _signInController.isGoogleSignedIn().then((bool isSignIn) async {
        // user already signin but not login
        if (isSignIn) {
          _userController.startUserStream(_signInController.user.uid);
        }

        //if user not login or signed out
        //go to signin page
        else {
          Get.to(SignInScreen());
        }
      });
    }

    //collect admin settings for bellow information
    //*check server is under maintaince or not
    //delivery charge
    //new user point
    //offer
    FirestoreReadFunction.settings().then((AdminSettings adminSettings) {
      if (adminSettings != null) {
        //update adminsettings
        _adminController.adminSettings = adminSettings;

        if (adminSettings.serverMaintenance) {
          Get.defaultDialog(title: "Server Mainterance");
        } else {
          _tryToSignIn();
        }
      } else {
        Get.defaultDialog(
          title: "Database connect failed.",
          onConfirm: () => Get.offAll(SplashScreen()),
        );
      }
    });

    return Scaffold(
      //full screen background
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: ColorPalette.colorSplash,
        ),

        //for visible nested container
        child: Align(
          alignment: Alignment.topCenter,

          child: Center(
            child: RaisedButton(
              onPressed: () {
                print("p am pressed");
              },
              child: Text("press me"),
            ),
          ),

          //outer circle
          // child: Container(
          //   height: Util.width(context,
          //       percent: Values.splashScreen_outerCircelPercent),
          //   width: Util.width(context,
          //       percent: Values.splashScreen_outerCircelPercent),
          //   margin: EdgeInsets.only(
          //     top: Util.height(context,
          //         percent: Values.splashScreen_marginTopPercent),
          //   ),
          //   decoration: Style.splashOuterCircle,

          //   //second circle
          //   child: Center(
          //     child: Container(
          //       height: Util.width(context,
          //           percent: Values.splashScreen_innerCircelPercent),
          //       width: Util.width(context,
          //           percent: Values.splashScreen_innerCircelPercent),
          //       decoration: Style.splashOuterCircle,

          //       //image
          //       child: Center(
          //         child: Padding(
          //           padding: Style.paddingAll,
          //           child: Image.asset(Assets.mainIcon),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ),
      ),
    );
  }
}
