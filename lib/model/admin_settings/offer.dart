import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/admin_settings/login_after_long_time_offer.dart';
import 'package:prosiddho/model/admin_settings/new_user_offer.dart';
import 'package:prosiddho/model/admin_settings/order_offer.dart';
import 'package:prosiddho/model/admin_settings/app_update_offer.dart';
import 'package:prosiddho/model/admin_settings/daily_login_offer.dart';

class Offer {
  LoginAfterLongTimeOffer loginAfterLongTime;
  NewUserOffer newUserOffer;
  OrderOffer orderOffer;
  AppUpdateOffer appUpdateOffer;
  DailyLoginOffer dailyLoginOffer;

  Offer({
    @required this.loginAfterLongTime,
    @required this.newUserOffer,
    @required this.orderOffer,
    @required this.appUpdateOffer,
    @required this.dailyLoginOffer,
  });

  factory Offer.formFirestore(dynamic data) {
    return Offer(
      loginAfterLongTime: LoginAfterLongTimeOffer.formFirestore(
          data[KeyWords.loginAfterLongTime]),
      newUserOffer: NewUserOffer.fromFirestore(data[KeyWords.newUser]),
      orderOffer: OrderOffer.fromFirestore(data[KeyWords.orderOffer]),
      appUpdateOffer:
          AppUpdateOffer.fromFirestore(data[KeyWords.appUpdateOffer]),
      dailyLoginOffer:
          DailyLoginOffer.fromFirestore(data[KeyWords.dailyLoginOffer]),
    );
  }
}
