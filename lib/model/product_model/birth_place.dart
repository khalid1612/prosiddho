import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class BirthPlace {
  String division;
  List<String> districts = List();

  BirthPlace({
    @required this.division,
    @required this.districts,
  });

  factory BirthPlace.fromFirestore(dynamic data) {
    List<String> temp = List();
    dynamic districts = data[KeyWords.birthPlace_district];
    int len = districts.length ?? 0;
    if (len > 0) {
      for (String district in districts) {
        temp.add(district.toString());
      }
    }

    return BirthPlace(
      division: data[KeyWords.birthPlace_division],
      districts: temp,
    );
  }
}
