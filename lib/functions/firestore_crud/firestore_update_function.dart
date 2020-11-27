import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/constant/utils.dart';
import 'package:prosiddho/constant/values.dart';
import 'package:prosiddho/controller/admin_controller.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/model/user_model/free_delivery_model.dart';
import 'package:prosiddho/model/user_model/gmail_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';
import 'package:prosiddho/model/user_model/address_model.dart';
import 'package:prosiddho/model/cart_model/cart_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';
import 'package:prosiddho/model/product_model/product_model.dart';

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

  static Future lastLogin() async {
    await DatabaseHelper.collectionUsers
        .doc(Get.find<UserController>().userModel.id)
        .update({KeyWords.userModel_LastLogin: Timestamp.now()})
        .then((value) {})
        .catchError((error) => print("last login update failed: $error"));
  }

  static Future address(List<Address> addressList) async {
    List<dynamic> data = [];
    for (Address oldAddress in addressList) {
      data.add(Address.toMap(address: oldAddress));
    }

    await DatabaseHelper.collectionUsers
        .doc(Get.find<UserController>().userModel.id)
        .update({KeyWords.userModel_Address: data})
        .then((value) {})
        .catchError((error) => print("last login update failed: $error"));
  }

  static Future offerUpdate() async {
    //get instanse for easy work
    final AdminSettings adminSettings =
        Get.find<AdminController>().adminSettings;

    //get instanse for easy work
    final UserModel userModel = Get.find<UserController>().userModel;

    //init value
    int point = 0;
    int freeDelivery = 0;
    List<String> msg = List();
    Map<String, dynamic> data = {};

    //check offer and update

    //*chekc login after long time
    if (Util.loginInterval(userModel.lastLogin).inDays >
            adminSettings.offer.loginAfterLongTime.dayInactive &&
        adminSettings.offer.loginAfterLongTime.dayInactive != 0) {
      //if point available
      if (adminSettings.offer.loginAfterLongTime.point > 0) {
        point += adminSettings.offer.loginAfterLongTime.point;
        msg.add(
          "Login after long time bonuce ${adminSettings.offer.loginAfterLongTime.point} points",
        );
      }

      //if free delivery available
      if (adminSettings.offer.loginAfterLongTime.freeDelivery > 0) {
        freeDelivery += adminSettings.offer.loginAfterLongTime.freeDelivery;
        msg.add(
          "Login after long time bonuce ${adminSettings.offer.loginAfterLongTime.freeDelivery} free delivery",
        );
      }
    }

    //*new user offer
    //new user  get offer after login succss at first

    //*app update offer
    if (Values.appVersion == adminSettings.appVersion) {
      if (!userModel.offerCollect.appUpdate) {
        if (adminSettings.offer.appUpdateOffer.point > 0) {
          point += adminSettings.offer.appUpdateOffer.point;
          msg.add(
            "App update bonuce:  ${adminSettings.offer.appUpdateOffer.point} points",
          );
          data["${KeyWords.userModel_offerCollect}.${KeyWords.offerCollect_appUpdate}"] =
              true;
        }
      }
    }

    //*daily login offer
    if (!userModel.offerCollect.dailyLogin) {
      if (adminSettings.offer.dailyLoginOffer.point > 0) {
        point += adminSettings.offer.dailyLoginOffer.point;
        msg.add(
          "daily login bonuce:  ${adminSettings.offer.dailyLoginOffer.point} points",
        );

        data["${KeyWords.userModel_offerCollect}.${KeyWords.offerCollect_dailyLogin}"] =
            true;
      }
    }

    if (point > 0 || freeDelivery > 0) {
      if (point > 0) {
        data[KeyWords.userModel_Point] = FieldValue.increment(point);
      }

      if (freeDelivery > 0) {
        List<dynamic> freeDeliveryList = [];

        if (userModel.freeDelivery.length > 0) {
          for (int i = 0, j = userModel.freeDelivery.length; i < j; i++) {
            FreeDelivery tempFreeDelivery = userModel.freeDelivery[i];

            if (tempFreeDelivery.lastDate == null) {
              tempFreeDelivery.deliveryLeft += freeDelivery;
            }

            freeDeliveryList.add(FreeDelivery.toMap(tempFreeDelivery));
          }
        } else {
          freeDeliveryList.add(
            FreeDelivery.toMap(
              FreeDelivery(
                deliveryLeft: freeDelivery,
                lastDate: null,
              ),
            ),
          );
        }

        data[KeyWords.userModel_FreeDelivery] = freeDeliveryList;
      }

      await DatabaseHelper.collectionUsers
          .doc(userModel.id)
          .update(data)
          .then((value) {
        Get.defaultDialog(
          onConfirm: () => print("Ok"),
          confirmTextColor: Colors.black,
          middleText: msg.toString(),
        );
      }).catchError((error) => print("last login update failed: $error"));
    }
  }

  static Future addTocart(CartModelProduct cartModelProduct) async {
    await DatabaseHelper.collectionCart
        .doc(Get.find<UserController>().userModel.id)
        .update({
          KeyWords.cartModel_productList: FieldValue.arrayUnion([
            CartModelProduct.toMap(cartModelProduct),
          ]),
        })
        .then((value) => print("cart update success"))
        .catchError(
          (error) => print("Failed to add cart item: $error"),
        );
  }

  static Future itemQuanity(cartModelProductDetails) async {
    await removeFromcart(cartModelProductDetails);
  }

  static Future removeFromcart(
    List<CartModelProductDetails> cartModelProductDetails,
  ) async {
    dynamic data = [];

    for (CartModelProductDetails cartItem in cartModelProductDetails) {
      data.add(CartModelProduct.toMap(cartItem.cartModelProduct));
    }

    await DatabaseHelper.collectionCart
        .doc(Get.find<UserController>().userModel.id)
        .update({'product_list': data})
        .then((value) => print("cart update success"))
        .catchError(
          (error) => print("Failed to add cart item: $error"),
        );
  }
}
