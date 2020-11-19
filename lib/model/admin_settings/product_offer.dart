import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class ProductOffer {
  int discountPercent;
  List<String> productId = List();

  ProductOffer({
    @required this.discountPercent,
    @required this.productId,
  });

  factory ProductOffer.fromFirestore(dynamic data) {
    var productIds = data[KeyWords.productOffer_productId];

    List<String> tempIds = List();

    if (productIds != null) {
      for (String id in productIds) {
        tempIds.add(id);
      }
    }

    return ProductOffer(
      discountPercent: data[KeyWords.productOffer_discountPercent],
      productId: productIds,
    );
  }
}
