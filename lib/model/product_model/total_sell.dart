import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class TotalSell {
  int totalOrder;
  double totalUnitSell;

  TotalSell({
    @required this.totalOrder,
    @required this.totalUnitSell,
  });

  factory TotalSell.fromFirestore(dynamic data) {
    return TotalSell(
      totalOrder: data[KeyWords.totalSell_TotalOrder],
      totalUnitSell: data[KeyWords.totalSell_TotalUnitSell],
    );
  }
}
