import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class NewUserOffer {
  int freeDelivery;
  int point;

  NewUserOffer({
    @required this.freeDelivery,
    @required this.point,
  });

  factory NewUserOffer.fromFirestore(dynamic data) {
    return NewUserOffer(
      freeDelivery: data[KeyWords.newUser_free_delivery],
      point: data[KeyWords.newUser_point],
    );
  }
}
