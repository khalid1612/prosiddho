import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class Price {
  double price;
  double quantity;

  Price({
    @required this.price,
    @required this.quantity,
  });

  factory Price.fromFirstore(dynamic data) {
    return Price(
      price: double.parse(data[KeyWords.price_price].toString()),
      quantity: double.parse(data[KeyWords.price_quantity].toString()),
    );
  }
}
