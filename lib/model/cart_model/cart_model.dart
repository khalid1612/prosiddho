import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

import 'cart_model_product.dart';

class CartModel {
  String id;
  List<CartModelProduct> cartModelProduct = List();
  Timestamp lastUpdate;

  CartModel({
    this.id,
    @required this.cartModelProduct,
    @required this.lastUpdate,
  });

  factory CartModel.init() {
    return CartModel(
      id: null,
      cartModelProduct: [],
      lastUpdate: null,
    );
  }

  factory CartModel.fromFirestore(DocumentSnapshot data) {
    int countProducts = data[KeyWords.cartModel_productList].length ?? 0;
    List<CartModelProduct> tempCartModelProduct = List();

    if (countProducts > 0) {
      for (int i = 0; i < countProducts; i++) {
        tempCartModelProduct.add(
          CartModelProduct.fromFirestore(
              data[KeyWords.cartModel_productList][i]),
        );
      }
    }

    return CartModel(
      id: data.id,
      cartModelProduct: tempCartModelProduct,
      lastUpdate: data[KeyWords.cartModel_lastUpdate],
    );
  }

  static Map<String, dynamic> toMap(CartModel cartModel) {
    dynamic data = [];
    for (CartModelProduct cartModelProduct in cartModel.cartModelProduct) {
      data.add(CartModelProduct.toMap(cartModelProduct));
    }

    return {
      KeyWords.cartModel_lastUpdate: Timestamp.now(),
      KeyWords.cartModel_productList: data,
    };
  }
}
