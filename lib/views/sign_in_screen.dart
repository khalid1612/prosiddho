import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/assets.dart';
import 'package:prosiddho/constant/utils.dart';
import 'package:prosiddho/controller/signin_controller.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Util.fullScreen(showTop: true, showBottom: true);

    Widget _iconWithName() {
      return Image.asset(
        Assets.mainIcon,
      );
    }

    Widget _signInButton({
      @required String text,
      Color color = Colors.amber,
    }) {
      return Container(
        width: Util.width(context, percent: 70),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //icon with name
            _iconWithName(),

            SizedBox(
              height: 100,
            ),

            //google signin
            InkWell(
              onTap: () async {
                Get.find<SigninController>().signInWithGoogle();
              },
              child: _signInButton(text: "Sign in with Google"),
            ),

            SizedBox(
              height: 20,
            ),

            //continue as Guest
            InkWell(
              onTap: () {},
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Continue as Guest"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
