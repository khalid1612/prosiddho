import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prosiddho/constant/keywords.dart';

class CouponUsedHistoryModel {
  String id;
  String code;
  String userId;
  Timestamp usedDate;

  CouponUsedHistoryModel({
    this.id,
    @required this.code,
    @required this.userId,
    @required this.usedDate,
  });

  static Map<String, dynamic> toMap(CouponUsedHistoryModel couponUsedHistory) {
    return {
      KeyWords.couponUsedHistoryModel_code: couponUsedHistory.code,
      KeyWords.couponUsedHistoryModel_userId: couponUsedHistory.userId,
      KeyWords.couponUsedHistoryModel_usedDate: couponUsedHistory.usedDate,
    };
  }

  factory CouponUsedHistoryModel.fromFirestore(DocumentSnapshot data,
      {String couponUsedHistoryModelId}) {
    return CouponUsedHistoryModel(
      id: couponUsedHistoryModelId ?? data.id,
      code: data[KeyWords.couponUsedHistoryModel_code],
      userId: data[KeyWords.couponUsedHistoryModel_userId],
      usedDate: data[KeyWords.couponUsedHistoryModel_usedDate],
    );
  }
}
