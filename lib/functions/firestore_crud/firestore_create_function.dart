import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/enum/status.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/model/user_model/account_status_model.dart';
import 'package:prosiddho/model/user_model/free_delivery_model.dart';
import 'package:prosiddho/model/user_model/gmail_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';

class FirestoreCreateFunction {
  static Future<UserModel> newUserWithGoogle(
      User user, AdminSettings adminSettings) async {
    //user initial data

    UserModel userModel = UserModel(
      name: user.displayName,
      phone: user.phoneNumber ?? null,
      birthDate: null,
      gamil: Gmail(
        uid: user.uid,
        email: user.email,
        displayName: user.displayName,
        photoURL: user.photoURL,
        phoneNumber: user.phoneNumber ?? null,
      ),
      crateDate: Timestamp.now(),
      accountStatus: AccountStatus(
        status: Status.Active.value,
        reason: null,
      ),
      address: null,
      point: adminSettings.newUserPoint,
      freeDelivery: [
        FreeDelivery(
          deliveryLeft: 1,
          lastDate: null, //null means lifetime
        )
      ],
      lastLogin: Timestamp.now(),
      isLogin: true,
    );

    //store data in database
    await DatabaseHelper.collectionUsers
        .doc(user.uid)
        .set(
          UserModel.toMap(userModel),
        )
        .then((value) {})
        .catchError(
          (error) => print("Failed to add user: $error"),
        );

    return userModel;
  }
}
