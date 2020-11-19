import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class LoginAfterLongTimeOffer {
  int dayInactive;
  int freeDelivery;
  int point;

  LoginAfterLongTimeOffer({
    @required this.dayInactive,
    @required this.freeDelivery,
    @required this.point,
  });

  factory LoginAfterLongTimeOffer.formFirestore(dynamic data) {
    return LoginAfterLongTimeOffer(
      dayInactive: data[KeyWords.loginAfterLongTime_dayInactive],
      freeDelivery: data[KeyWords.loginAfterLongTime_freeDelivery],
      point: data[KeyWords.loginAfterLongTime_point],
    );
  }
}
