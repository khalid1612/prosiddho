import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class FreeDelivery {
  //how many free delivery left
  int deliveryLeft;
  //lastDate null means life time
  Timestamp lastDate;

  FreeDelivery({
    @required this.deliveryLeft,
    @required this.lastDate,
  });

  factory FreeDelivery.fromFirestore(dynamic data) {
    return FreeDelivery(
      deliveryLeft: data[KeyWords.delivery_DeliveryLeft],
      lastDate: data[KeyWords.delivery_LastDate],
    );
  }

  factory FreeDelivery.dummy() {
    return FreeDelivery(
      deliveryLeft: 0,
      lastDate: null,
    );
  }

  static Map<String, dynamic> toMap(FreeDelivery freeDelivery) {
    return {
      KeyWords.delivery_DeliveryLeft: freeDelivery.deliveryLeft,
      KeyWords.delivery_LastDate: freeDelivery.lastDate,
    };
  }
}
