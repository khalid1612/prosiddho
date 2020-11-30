import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

import '../user_model/address_model.dart';
import '../payment_details.dart';
import 'order_model_product.dart';

class OrderModel {
  String id;
  Address address;
  String cancelReason;
  String userId;
  String userName;
  String userImage;
  Timestamp orderTime;
  List<PaymentDetails> paymentDetails = List();
  String phone;
  List<OrderModelProduct> productDetails = List();
  String status;
  Timestamp statusChangeTime;
  double totalPrice;
  double due;
  double profit;
  double deliveryFee;
  String couponCode;

  OrderModel({
    this.id,
    @required this.address,
    @required this.cancelReason,
    @required this.userId,
    @required this.userName,
    @required this.userImage,
    @required this.orderTime,
    @required this.paymentDetails,
    @required this.phone,
    @required this.productDetails,
    @required this.status,
    @required this.statusChangeTime,
    @required this.totalPrice,
    @required this.due,
    @required this.profit,
    @required this.deliveryFee,
    @required this.couponCode,
  });

  factory OrderModel.fromFirestore(DocumentSnapshot data, {String orderId}) {
    int countPaymentDetails =
        data[KeyWords.orderModel_paymentDetails].length ?? 0;
    List<PaymentDetails> tempPaymentDetails = List();

    int countProductDetails =
        data[KeyWords.orderModel_productDetails].length ?? 0;
    List<OrderModelProduct> tempProductDetails = List();

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
          OrderModelProduct.fromFirestore(
              data[KeyWords.orderModel_productDetails][i]),
        );
      }
    }

    return OrderModel(
      id: orderId ?? data.id,
      address: Address.fromFirestore(data[KeyWords.orderModel_address]),
      cancelReason: data[KeyWords.orderModel_cancelReason],
      userId: data[KeyWords.orderModel_userId],
      userName: data[KeyWords.orderModel_userName],
      userImage: data[KeyWords.orderModel_userImage],
      orderTime: data[KeyWords.orderModel_orderTime],
      paymentDetails: tempPaymentDetails,
      phone: data[KeyWords.orderModel_phone],
      productDetails: tempProductDetails,
      status: data[KeyWords.orderModel_status],
      statusChangeTime: data[KeyWords.orderModel_statusChangeTime],
      totalPrice: data[KeyWords.orderModel_totalPrice],
      due: data[KeyWords.orderModel_due],
      profit: data[KeyWords.orderModel_profit],
      deliveryFee: data[KeyWords.orderModel_deliveryFee],
      couponCode: data[KeyWords.orderModel_couponCode],
    );
  }

  static Map<String, dynamic> toMap(OrderModel orderModel) {
    List<dynamic> paymentDetailsMap = List();
    List<dynamic> productDetailsMap = List();

    for (PaymentDetails paymentDetails in orderModel.paymentDetails) {
      paymentDetailsMap.add(PaymentDetails.toMap(paymentDetails));
    }

    for (OrderModelProduct orderModelProduct in orderModel.productDetails) {
      productDetailsMap.add(OrderModelProduct.toMap(orderModelProduct));
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
      KeyWords.orderModel_totalPrice: orderModel.totalPrice,
      KeyWords.orderModel_due: orderModel.due,
      KeyWords.orderModel_profit: orderModel.profit,
      KeyWords.orderModel_deliveryFee: orderModel.deliveryFee,
      KeyWords.orderModel_couponCode: orderModel.couponCode,
    };
  }
}
