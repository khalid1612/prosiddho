import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class DailyLoginOffer {
  int point;

  DailyLoginOffer({
    @required this.point,
  });

  factory DailyLoginOffer.fromFirestore(dynamic data) {
    return DailyLoginOffer(point: data[KeyWords.dailyLoginOffer_point]);
  }
}
