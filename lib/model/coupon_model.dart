import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prosiddho/constant/keywords.dart';

class CouponModel {
  String id;
  String availableUserId;
  String code;
  Timestamp createDate;
  int delivery;
  double discount;
  Timestamp expireDate;
  bool isActive;
  bool isUsed;
  double minAmountOrder;
  String name;
  int perUserUsed;
  int totalUseable;
  int used;
  Timestamp userdDate;

  CouponModel({
    this.id,
    @required this.availableUserId,
    @required this.code,
    @required this.createDate,
    @required this.delivery,
    @required this.discount,
    @required this.expireDate,
    @required this.isActive,
    @required this.isUsed,
    @required this.minAmountOrder,
    @required this.name,
    @required this.perUserUsed,
    @required this.totalUseable,
    @required this.used,
    @required this.userdDate,
  });

  static Map<String, dynamic> toMap(CouponModel couponModel) {
    return {
      KeyWords.couponModel_availableUserId: couponModel.availableUserId,
      KeyWords.couponModel_code: couponModel.code,
      KeyWords.couponModel_createDate: couponModel.createDate,
      KeyWords.couponModel_delivery: couponModel.delivery,
      KeyWords.couponModel_discount: couponModel.discount,
      KeyWords.couponModel_expireDate: couponModel.expireDate,
      KeyWords.couponModel_isActive: couponModel.isActive,
      KeyWords.couponModel_isUsed: couponModel.isUsed,
      KeyWords.couponModel_minAmountOrder: couponModel.minAmountOrder,
      KeyWords.couponModel_name: couponModel.name,
      KeyWords.couponModel_perUserUsed: couponModel.perUserUsed,
      KeyWords.couponModel_totalUseable: couponModel.totalUseable,
      KeyWords.couponModel_used: couponModel.used,
      KeyWords.couponModel_usedDate: couponModel.userdDate,
    };
  }

  factory CouponModel.fromFirestore(DocumentSnapshot data, {String couponId}) {
    return CouponModel(
      id: couponId ?? data.id,
      availableUserId: data[KeyWords.couponModel_availableUserId],
      code: data[KeyWords.couponModel_code],
      createDate: data[KeyWords.couponModel_createDate],
      delivery: data[KeyWords.couponModel_delivery],
      discount: data[KeyWords.couponModel_discount],
      expireDate: data[KeyWords.couponModel_expireDate],
      isActive: data[KeyWords.couponModel_isActive],
      isUsed: data[KeyWords.couponModel_isUsed],
      minAmountOrder: data[KeyWords.couponModel_minAmountOrder],
      name: data[KeyWords.couponModel_name],
      perUserUsed: data[KeyWords.couponModel_perUserUsed],
      totalUseable: data[KeyWords.couponModel_totalUseable],
      used: data[KeyWords.couponModel_used],
      userdDate: data[KeyWords.couponModel_usedDate],
    );
  }
}
