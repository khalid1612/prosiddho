import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class OfferCollect {
  bool dailyLogin;
  bool appUpdate;

  OfferCollect({
    @required this.dailyLogin,
    @required this.appUpdate,
  });

  factory OfferCollect.formFirestore(dynamic data) {
    return OfferCollect(
      dailyLogin: data[KeyWords.offerCollect_dailyLogin],
      appUpdate: data[KeyWords.offerCollect_appUpdate],
    );
  }

  static Map<String, dynamic> toMap(OfferCollect freeDelivery) {
    return {
      KeyWords.offerCollect_appUpdate: freeDelivery.appUpdate,
      KeyWords.offerCollect_dailyLogin: freeDelivery.dailyLogin,
    };
  }
}
