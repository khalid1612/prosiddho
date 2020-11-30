import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class OrderModelProduct {
  String productId;
  String productName;
  int quantity;
  int extra;
  double totalPrice;
  double regularPrice;
  double offerPrice;

  OrderModelProduct({
    @required this.productId,
    @required this.productName,
    @required this.quantity,
    @required this.extra,
    @required this.totalPrice,
    @required this.regularPrice,
    @required this.offerPrice,
  });

  factory OrderModelProduct.fromFirestore(dynamic data) {
    return OrderModelProduct(
      productId: data[KeyWords.orderModel_product_productId],
      productName: data[KeyWords.orderModel_product_name],
      quantity: data[KeyWords.orderModel_product_quantity],
      extra: data[KeyWords.orderModel_product_extra],
      totalPrice: data[KeyWords.orderModel_product_totalPrice],
      regularPrice: data[KeyWords.orderModel_product_regularPrice],
      offerPrice: data[KeyWords.orderModel_product_offerPrice],
    );
  }

  static Map<String, dynamic> toMap(OrderModelProduct orderModelProduct) {
    return {
      KeyWords.orderModel_product_productId: orderModelProduct.productId,
      KeyWords.orderModel_product_name: orderModelProduct.productName,
      KeyWords.orderModel_product_quantity: orderModelProduct.quantity,
      KeyWords.orderModel_product_extra: orderModelProduct.extra,
      KeyWords.orderModel_product_totalPrice: orderModelProduct.totalPrice,
      KeyWords.orderModel_product_regularPrice: orderModelProduct.regularPrice,
      KeyWords.orderModel_product_offerPrice: orderModelProduct.offerPrice,
    };
  }
}
