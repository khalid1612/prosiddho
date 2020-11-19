import 'package:flutter/material.dart';

class CategoryModel {
  String name;
  String imagePath;
  int colorCode;
  List<String> districts;

  CategoryModel({
    @required this.name,
    @required this.imagePath,
    @required this.colorCode,
    @required this.districts,
  });
}
