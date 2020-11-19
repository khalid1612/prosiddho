import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthFunction {
  static GoogleSignIn googleSignIn = GoogleSignIn();
  static FirebaseAuth auth = FirebaseAuth.instance;

  static Future<User> googleAuth() async {
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;

    // get the credentials to (access / id token)
    // to sign in via Firebase Authentication
    AuthCredential authCredential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );

    final UserCredential authResult =
        await auth.signInWithCredential(authCredential);

    return authResult.user;
  }
}
