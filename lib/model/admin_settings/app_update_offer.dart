import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class AppUpdateOffer {
  int point;

  AppUpdateOffer({
    @required this.point,
  });

  factory AppUpdateOffer.fromFirestore(dynamic data) {
    return AppUpdateOffer(point: data[KeyWords.appUpdateOffer_point]);
  }
}
