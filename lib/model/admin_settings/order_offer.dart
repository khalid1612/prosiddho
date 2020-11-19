import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class OrderOffer {
  int amountGte;
  int discountPercent;

  OrderOffer({
    @required this.amountGte,
    @required this.discountPercent,
  });

  factory OrderOffer.fromFirestore(dynamic data) {
    return OrderOffer(
      amountGte: data[KeyWords.orderOffer_amountGte],
      discountPercent: data[KeyWords.orderOffer_discountPercent],
    );
  }
}
