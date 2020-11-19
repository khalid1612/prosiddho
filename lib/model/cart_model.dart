import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:prosiddho/constant/keywords.dart';

class CartModel {
  String id;
  String productName;
  String productUnit;
  String productId;
  String productImageUrl;
  String userId;
  Timestamp addedTime;
  double quantity;
  double totalPrice;

  CartModel({
    this.id,
    @required this.productId,
    @required this.productName,
    @required this.productUnit,
    @required this.productImageUrl,
    @required this.userId,
    @required this.addedTime,
    @required this.quantity,
    @required this.totalPrice,
  });

  static Map<String, dynamic> toMap(CartModel cartModel) {
    return {
      KeyWords.cartModel_productId: cartModel.productId,
      KeyWords.cartModel_productName: cartModel.productName,
      KeyWords.cartModel_productUnit: cartModel.productUnit,
      KeyWords.cartModel_productImageUrl: cartModel.productImageUrl,
      KeyWords.cartModel_userId: cartModel.userId,
      KeyWords.cartModel_addedTime: cartModel.addedTime,
      KeyWords.cartModel_quantity: cartModel.quantity,
      KeyWords.cartModel_totalPrice: cartModel.totalPrice,
    };
  }

  factory CartModel.fromFirestore(DocumentSnapshot data, {String id}) {
    return CartModel(
      id: id ?? data.id,
      productId: data[KeyWords.cartModel_productName],
      productName: data[KeyWords.cartModel_productUnit],
      productUnit: data[KeyWords.cartModel_totalPrice],
      productImageUrl: data[KeyWords.cartModel_productImageUrl],
      userId: data[KeyWords.cartModel_userId],
      addedTime: data[KeyWords.cartModel_addedTime],
      quantity: data[KeyWords.cartModel_quantity],
      totalPrice: data[KeyWords.cartModel_totalPrice],
    );
  }
}
