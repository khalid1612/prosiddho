import 'package:flutter/material.dart';

class PaymentModel {
  String name;
  String getway;
  String imagePath;
  Function onTap;

  PaymentModel({
    @required this.name,
    @required this.getway,
    @required this.imagePath,
    @required this.onTap,
  });
}
