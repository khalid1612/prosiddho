import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class BuyGet {
  //how much product buy (Buy 3)
  int quantity;
  //how much extra (Get 1)
  int extra;

  BuyGet({
    @required this.quantity,
    @required this.extra,
  });

  factory BuyGet.fromFirestore(dynamic data) {
    return BuyGet(
      quantity: data[KeyWords.buyGet_quantity],
      extra: data[KeyWords.buyGet_extra],
    );
  }
}
