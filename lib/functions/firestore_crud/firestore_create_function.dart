import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/controller/admin_controller.dart';
import 'package:prosiddho/enum/status.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/model/user_model/account_status_model.dart';
import 'package:prosiddho/model/user_model/free_delivery_model.dart';
import 'package:prosiddho/model/user_model/gmail_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';
import 'package:prosiddho/model/user_model/offer_collect.dart';

class FirestoreCreateFunction {
  static Future<UserModel> newUserWithGoogle(User user) async {
    //user initial data
    final AdminSettings adminSettings =
        Get.find<AdminController>().adminSettings;

    //setup a new user instance
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
      point: adminSettings.offer.newUserOffer.point,
      freeDelivery: [
        FreeDelivery(
          deliveryLeft: adminSettings.offer.newUserOffer.freeDelivery,
          lastDate: null, //*null means lifetime
        )
      ],
      lastLogin: Timestamp.now(),
      isLogin: true,
      offerCollect: OfferCollect(
        appUpdate: false,
        dailyLogin: false,
      ),
    );

    //store data in database
    await DatabaseHelper.collectionUsers
        .doc(user.uid)
        .set(
          UserModel.toMap(userModel),
        )
        .then((value) {
      String msg = '';
      if (adminSettings.offer.newUserOffer.point > 0) {
        msg = "You got ${adminSettings.offer.newUserOffer.point} points";
      }

      if (adminSettings.offer.newUserOffer.freeDelivery > 0) {
        msg = msg.length > 0
            ? " and ${adminSettings.offer.newUserOffer.freeDelivery} free delivery"
            : " You got ${adminSettings.offer.newUserOffer.freeDelivery} free delivery";
      }

      if (msg.length > 0) {
        Get.defaultDialog(onConfirm: () => print("Ok"), middleText: msg);
      }
    }).catchError(
      (error) => print("Failed to add user: $error"),
    );

    return userModel;
  }
}
