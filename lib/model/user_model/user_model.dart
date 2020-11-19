import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

import 'account_status_model.dart';
import 'address_model.dart';
import 'free_delivery_model.dart';
import 'gmail_model.dart';

class UserModel {
  String id;
  String name;
  String phone;
  String birthDate;
  Gmail gamil;
  Timestamp crateDate;
  AccountStatus accountStatus;
  List<Address> address = List();
  int point;
  List<FreeDelivery> freeDelivery = List();
  Timestamp lastLogin;
  bool isLogin;

  UserModel({
    this.id,
    @required this.name,
    @required this.phone,
    @required this.birthDate,
    @required this.gamil,
    @required this.crateDate,
    @required this.accountStatus,
    @required this.address,
    @required this.point,
    @required this.freeDelivery,
    @required this.lastLogin,
    @required this.isLogin,
  });

  factory UserModel.init() {
    return UserModel(
      id: null,
      name: null,
      phone: null,
      birthDate: null,
      gamil: null,
      crateDate: null,
      accountStatus: null,
      address: null,
      point: null,
      freeDelivery: null,
      lastLogin: null,
      isLogin: null,
    );
  }

  factory UserModel.fromFirestore(DocumentSnapshot data, {String userId}) {
    int countAddress = data[KeyWords.userModel_Address].length ?? 0;
    List<Address> tempAddress = List();

    if (countAddress > 0) {
      for (int i = 0; i < countAddress; i++) {
        tempAddress.add(
          Address.fromFirestore(data[KeyWords.userModel_Address][i]),
        );
      }
    }

    int countFreeDelivery = data[KeyWords.userModel_FreeDelivery].length ?? 0;
    List<FreeDelivery> tempFreeDelivery = List();

    if (countFreeDelivery > 0) {
      for (int i = 0; i < countFreeDelivery; i++) {
        tempFreeDelivery.add(
          FreeDelivery.fromFirestore(data[KeyWords.userModel_FreeDelivery][i]),
        );
      }
    }

    return UserModel(
      id: userId ?? data.id,
      name: data[KeyWords.userModel_Name],
      phone: data[KeyWords.userModel_Phone],
      birthDate: data[KeyWords.userModel_BirthDate],
      gamil: Gmail.fromFirestore(data[KeyWords.userModel_Gamil]),
      crateDate: data[KeyWords.userModel_CrateDate],
      accountStatus:
          AccountStatus.fromFirestore(data[KeyWords.userModel_AccountStatus]),
      address: tempAddress,
      point: data[KeyWords.userModel_Point],
      freeDelivery: tempFreeDelivery,
      lastLogin: data[KeyWords.userModel_LastLogin],
      isLogin: data[KeyWords.userModel_IsLogin],
    );
  }

  static Map<String, dynamic> toMap(UserModel userModel) {
    return {
      KeyWords.userModel_Name: userModel.name,
      KeyWords.userModel_Phone: userModel.phone,
      KeyWords.userModel_BirthDate: userModel.birthDate,
      KeyWords.userModel_Gamil: Gmail.toMap(userModel.gamil),
      KeyWords.userModel_CrateDate: userModel.crateDate,
      KeyWords.userModel_AccountStatus:
          AccountStatus.toMap(userModel.accountStatus),
      KeyWords.userModel_Address: [Address.toMap()],
      KeyWords.userModel_Point: userModel.point,
      KeyWords.userModel_FreeDelivery: [
        FreeDelivery.toMap(userModel.freeDelivery[0])
      ],
      KeyWords.userModel_LastLogin: userModel.lastLogin,
      KeyWords.userModel_IsLogin: userModel.isLogin,
    };
  }
}
