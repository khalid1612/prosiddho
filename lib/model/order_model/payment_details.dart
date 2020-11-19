import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class PaymentDetails {
  //cash on delivery, bkash, dbbl....
  String getway;
  double amount;
  Timestamp time;
  String accountId;
  String accountHolderName;

  PaymentDetails({
    @required this.getway,
    @required this.amount,
    @required this.time,
    @required this.accountId,
    @required this.accountHolderName,
  });

  factory PaymentDetails.fromFirestore(dynamic data) {
    return PaymentDetails(
      getway: data[KeyWords.paymentDetails_getway],
      amount: data[KeyWords.paymentDetails_amount],
      time: data[KeyWords.paymentDetails_time],
      accountId: data[KeyWords.paymentDetails_accountId],
      accountHolderName: data[KeyWords.paymentDetails_accountHolderName],
    );
  }

  static Map<String, dynamic> toMap(PaymentDetails paymentDetails) {
    return {
      KeyWords.paymentDetails_getway: paymentDetails.getway,
      KeyWords.paymentDetails_amount: paymentDetails.amount,
      KeyWords.paymentDetails_time: paymentDetails.time,
      KeyWords.paymentDetails_accountId: paymentDetails.accountId,
      KeyWords.paymentDetails_accountHolderName:
          paymentDetails.accountHolderName,
    };
  }
}
