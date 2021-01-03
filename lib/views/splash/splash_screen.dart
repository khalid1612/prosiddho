import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/assets.dart';
import 'package:prosiddho/controller/admin_controller.dart';
import 'package:prosiddho/controller/signin_controller.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/buttons.dart';
import 'package:prosiddho/style/bouncing_button.dart';
import 'package:prosiddho/style/dialog.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SigninController _signInController = Get.put(SigninController());
  final AdminController _adminController = Get.put(AdminController());
  final UserController _userController = Get.put(UserController());

  final double outerCircleWidthPercent = .6;
  final double innerCircleWidthPercent = .4;

  bool isLogin = false;
  bool showSignInUI = false;

  //0 == init anim on up
  //1 == show login ui

  int animState;

  final double logoHeight = 200.0;
  final double logoWidth = 200.0;
  double top = 0;
  double left = 0;
  double initTop;

  @override
  void initState() {
    print("init state");
    animState = 0;

    top = initTop = (Get.height / 2) - (logoHeight / 2);
    left = (Get.width / 2) - (logoWidth / 2);

    //collect admin settings for bellow information
    //*check server is under maintaince or not
    //*delivery charge
    //*new user point
    //*offers
    FirestoreReadFunction.settings().then((AdminSettings adminSettings) {
      if (adminSettings != null) {
        //update adminsettings
        _adminController.adminSettings = adminSettings;

        if (adminSettings.serverMaintenance) {
          CustomDialog.serverMaintenance();
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

    super.initState();
  }

  //start a user stream
  //bacause if user change his name or phone or address or
  //user used a  free delivery or earn points or
  //make an order then it will update automatically
  void _tryToSignIn() async {
    await _signInController.isGoogleSignedIn().then((bool isSignIn) async {
      this.isLogin = isSignIn;

      //start amination without delay
      Future.delayed(Duration.zero).then((value) {
        setState(() {
          top = initTop - 50;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //full screen background
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          color: ColorPalette.primaryPurple,

          //for visible nested container and icon in center
          child: Stack(
            children: [
              animateLogoPosition(),
              signinUI(),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedOpacity signinUI() {
    return AnimatedOpacity(
      duration: Duration(milliseconds: 500),
      opacity: showSignInUI ? 1.0 : 0.0,
      child: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: (Get.height / 2) * .5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //google sign button
              BouncingButton(
                onPress: () async {
                  await Get.find<SigninController>().signInWithGoogle();
                },
                child: Buttons.signInButton(
                  Colors.white,
                  FontAwesomeIcons.google,
                  ColorPalette.primaryRed,
                  "Sign in with Google",
                ),
              ),

              SizedBox(height: 10),

              //guest signin button]
              Buttons.guestButton(),
            ],
          ),
        ),
      ),
    );
  }

  AnimatedPositioned animateLogoPosition() {
    return AnimatedPositioned(
      top: top,
      left: left,
      duration: Duration(seconds: 1),
      curve: Curves.bounceIn,
      onEnd: () {
        setState(() {
          if (animState == 0) {
            top = isLogin ? initTop : 100;
            animState++;
          } else if (animState == 1) {
            if (isLogin) {
              // user already signed up and still logged in
              _userController.startUserStream(_signInController.user.uid);
            } else {
              showSignInUI = true;
            }

            animState++;
          }
        });
      },
      child: logo(),
    );
  }

  Center logo() {
    return Center(
      child: Container(
        width: logoWidth,
        height: logoHeight,
        child: Image.asset(Assets.mainIcon),
      ),
    );
  }
}
