import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class AppUpdateOffer {
  int point;
  String posterPath;

  AppUpdateOffer({
    @required this.point,
    @required this.posterPath,
  });

  factory AppUpdateOffer.fromFirestore(dynamic data) {
    return AppUpdateOffer(
      point: data[KeyWords.appUpdateOffer_point],
      posterPath: data[KeyWords.appUpdateOffer_posterPath],
    );
  }
}
