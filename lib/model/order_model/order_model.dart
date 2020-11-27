import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

import '../cart_model/cart_model.dart';
import '../user_model/address_model.dart';
import 'payment_details.dart';

class OrderModel {
  String id;
  Address address;
  String cancelReason;
  String userId;
  String userName;
  Timestamp orderTime;
  List<PaymentDetails> paymentDetails = List();
  String phone;
  List<CartModel> productDetails = List();
  String status;
  Timestamp statusChangeTime;
  double payment;
  double discount;
  double totalPrice;
  double totalPayable;
  double deliveryFee;

  OrderModel({
    this.id,
    @required this.address,
    @required this.cancelReason,
    @required this.userId,
    @required this.userName,
    @required this.orderTime,
    @required this.paymentDetails,
    @required this.phone,
    @required this.productDetails,
    @required this.status,
    @required this.statusChangeTime,
    @required this.payment,
    @required this.discount,
    @required this.totalPrice,
    @required this.totalPayable,
    @required this.deliveryFee,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot data, {String orderId}) {
    int countPaymentDetails =
        data[KeyWords.orderModel_paymentDetails].length ?? 0;
    List<PaymentDetails> tempPaymentDetails = List();

    int countProductDetails =
        data[KeyWords.orderModel_productDetails].length ?? 0;
    List<CartModel> tempProductDetails = List();

    if (countPaymentDetails > 0) {
      for (int i = 0; i < countPaymentDetails; i++) {
        tempPaymentDetails.add(
          PaymentDetails.fromFirestore(
              data[KeyWords.orderModel_paymentDetails][i]),
        );
      }
    }

    if (countProductDetails > 0) {
      for (int i = 0; i < countProductDetails; i++) {
        tempProductDetails.add(
          CartModel.fromFirestore(data[KeyWords.orderModel_productDetails][i]),
        );
      }
    }

    return OrderModel(
      id: orderId ?? data.id,
      address: Address.fromFirestore(data[KeyWords.orderModel_address]),
      cancelReason: data[KeyWords.orderModel_cancelReason],
      userId: data[KeyWords.orderModel_userId],
      userName: data[KeyWords.orderModel_userName],
      orderTime: data[KeyWords.orderModel_orderTime],
      paymentDetails: tempPaymentDetails,
      phone: data[KeyWords.orderModel_phone],
      productDetails: tempProductDetails,
      status: data[KeyWords.orderModel_status],
      statusChangeTime: data[KeyWords.orderModel_statusChangeTime],
      payment: data[KeyWords.orderModel_payment],
      discount: data[KeyWords.orderModel_discount],
      totalPrice: data[KeyWords.orderModel_totalPrice],
      totalPayable: data[KeyWords.orderModel_totalPayable],
      deliveryFee: data[KeyWords.orderModel_deliveryFee],
    );
  }

  static Map<String, dynamic> toMap(OrderModel orderModel) {
    List<dynamic> paymentDetailsMap = List();
    List<dynamic> productDetailsMap = List();

    for (PaymentDetails paymentDetails in orderModel.paymentDetails) {
      paymentDetailsMap.add(PaymentDetails.toMap(paymentDetails));
    }

    return {
      KeyWords.orderModel_address: Address.toMap(address: orderModel.address),
      KeyWords.orderModel_cancelReason: orderModel.cancelReason,
      KeyWords.orderModel_userId: orderModel.userId,
      KeyWords.orderModel_userName: orderModel.userName,
      KeyWords.orderModel_orderTime: orderModel.orderTime,
      KeyWords.orderModel_paymentDetails: paymentDetailsMap,
      KeyWords.orderModel_phone: orderModel.phone,
      KeyWords.orderModel_productDetails: productDetailsMap,
      KeyWords.orderModel_status: orderModel.status,
      KeyWords.orderModel_statusChangeTime: orderModel.statusChangeTime,
      KeyWords.orderModel_payment: orderModel.payment,
      KeyWords.orderModel_discount: orderModel.discount,
      KeyWords.orderModel_totalPrice: orderModel.totalPrice,
      KeyWords.orderModel_totalPayable: orderModel.totalPayable,
      KeyWords.orderModel_deliveryFee: orderModel.deliveryFee,
    };
  }
}
