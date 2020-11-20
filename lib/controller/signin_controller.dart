import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/enum/sign_in_method.dart';
import 'package:prosiddho/functions/auth/google_auth_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_create_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/views/sign_in_screen.dart';

class SigninController extends GetxController {
  SignInMethod signInMethod;
  User user;

  /*check user alrady login or not*/
  Future<bool> isGoogleSignedIn() async {
    //is user already sign in using goolge
    bool isSignedIn = await GoogleAuthFunction.googleSignIn.isSignedIn();

    if (isSignedIn) {
      //update signin method
      signInMethod = SignInMethod.Google;

      //update instance of current user
      this.user = GoogleAuthFunction.auth.currentUser;
    }

    return isSignedIn;
  }

  Future signInWithGoogle() async {
    //try to signin with google
    await GoogleAuthFunction.googleAuth().then((User user) async {
      //update signin method
      signInMethod = SignInMethod.Google;

      //update instance of current user
      this.user = user;

      //for successfully signin
      if (user != null) {
        // check user details available or not in database
        // if available then old user
        //other wise new user
        await FirestoreReadFunction.user(user.uid).then((userModel) async {
          //if user is new then
          //add uer details in database
          if (userModel == null) {
            await FirestoreCreateFunction.newUserWithGoogle(user);
          }

          Get.find<UserController>().startUserStream(user.uid);
        });
        Get.snackbar("Sign in successfully", "Enjoy yourself");
      }
    });
  }

  Future signOutFromGoogle() async {
    await GoogleAuthFunction.googleSignIn.signOut();

    isGoogleSignedIn().then((bool isSignIn) {
      if (isSignIn) {
        Get.defaultDialog(
          title: "signout failed!",
          middleText: "Please try again",
        );
      } else {
        //reset user
        Get.find<UserController>().reset();
        print("goolge sign out successfully");

        //reset all signin details
        signInMethod = null;
        user = null;

        //go to login page and finish all previous page
        Get.offAll(SignInScreen());
      }
    });
  }
}
