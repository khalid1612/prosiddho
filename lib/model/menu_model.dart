import 'package:flutter/material.dart';

class MenuModel {
  String name;
  IconData icon;
  Color color;
  Function onTap;

  MenuModel({
    @required this.name,
    @required this.icon,
    @required this.color,
    @required this.onTap,
  });
}
