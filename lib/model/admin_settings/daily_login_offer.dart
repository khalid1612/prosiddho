import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class DailyLoginOffer {
  int point;
  String posterPath;

  DailyLoginOffer({
    @required this.point,
    @required this.posterPath,
  });

  factory DailyLoginOffer.fromFirestore(dynamic data) {
    return DailyLoginOffer(
      point: data[KeyWords.dailyLoginOffer_point],
      posterPath: data[KeyWords.appUpdateOffer_posterPath],
    );
  }
}
