import 'package:firebase_auth/firebase_auth.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/user_model/gmail_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';

class FirestoreUpdateFunction {
  static Future updateUserGmail(UserModel userModel, User user) async {
    if (userModel.gamil.displayName != user.displayName ||
        userModel.gamil.phoneNumber != user.phoneNumber ||
        userModel.gamil.photoURL != user.photoURL) {
      Gmail gmail = Gmail(
        uid: userModel.id ?? user.uid,
        email: userModel.gamil.email ?? user.email,
        displayName: user.displayName ?? userModel.gamil.displayName,
        photoURL: user.photoURL ?? userModel.gamil.photoURL,
        phoneNumber: user.phoneNumber ?? userModel.phone,
      );

      await DatabaseHelper.collectionUsers
          .doc(userModel.id ?? user.uid)
          .update({KeyWords.userModel_Gamil: Gmail.toMap(gmail)})
          .then((value) {})
          .catchError((error) => print("Gmail update failed: $error"));
    }
  }
}
