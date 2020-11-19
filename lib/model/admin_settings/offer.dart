import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/admin_settings/login_after_long_time_offer.dart';
import 'package:prosiddho/model/admin_settings/new_user_offer.dart';
import 'package:prosiddho/model/admin_settings/order_offer.dart';
import 'package:prosiddho/model/admin_settings/product_offer.dart';

class Offer {
  LoginAfterLongTimeOffer loginAfterLongTime;
  NewUserOffer newUserOffer;
  OrderOffer orderOffer;
  ProductOffer productOffer;

  Offer({
    @required this.loginAfterLongTime,
    @required this.newUserOffer,
    @required this.orderOffer,
    @required this.productOffer,
  });

  factory Offer.formFirestore(dynamic data) {
    return Offer(
      loginAfterLongTime: LoginAfterLongTimeOffer.formFirestore(
          data[KeyWords.loginAfterLongTime]),
      newUserOffer: NewUserOffer.fromFirestore(data[KeyWords.newUser]),
      orderOffer: OrderOffer.fromFirestore(data[KeyWords.orderOffer]),
      productOffer: ProductOffer.fromFirestore(data[KeyWords.productOffer]),
    );
  }
}
