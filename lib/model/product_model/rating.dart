import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class Rating {
  double average;
  int userCount;

  Rating({
    @required this.average,
    @required this.userCount,
  });

  factory Rating.fromFirestore(dynamic data) {
    return Rating(
      average: data[KeyWords.rating_average],
      userCount: data[KeyWords.rating_userCount],
    );
  }
}
