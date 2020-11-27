import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class CartModelProduct {
  String productId;
  int quantity;
  Timestamp addedTime;

  CartModelProduct({
    @required this.productId,
    @required this.quantity,
    @required this.addedTime,
  });

  factory CartModelProduct.fromFirestore(dynamic data) {
    return CartModelProduct(
      productId: data[KeyWords.cartModelProduct_productId],
      quantity: data[KeyWords.cartModelProduct_quantity],
      addedTime: data[KeyWords.cartModelProduct_date],
    );
  }

  static Map<String, dynamic> toMap(CartModelProduct cartModelProduct) {
    return {
      KeyWords.cartModelProduct_productId: cartModelProduct.productId,
      KeyWords.cartModelProduct_quantity: cartModelProduct.quantity,
      KeyWords.cartModelProduct_date: cartModelProduct.addedTime,
    };
  }
}
