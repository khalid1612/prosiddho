import 'package:flutter/material.dart';
import 'package:prosiddho/data/data.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:get/get.dart';
import 'package:prosiddho/views/division_with_district/division_with_district.dart';

class HomeDivision extends StatelessWidget {
  //total division
  final int totalDivisions = Data.division.length;
  final double itemHeight = 84.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: totalDivisions,
        itemBuilder: (context, index) => GestureDetector(
          onTap: () {
            Get.to(
              DivisionWithDistrict(
                index: index,
              ),
            );
          },
          child: _divisionItem(index),
        ),
      ),
    );
  }

  //division item
  Widget _divisionItem(int index) => Align(
        child: Container(
          width: 125,
          height: itemHeight,
          margin: Style.marginHorizontalListview(totalDivisions, index),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: ColorPalette.secondary,
            image: DecorationImage(
              image: AssetImage(Data.division[index].imagePath),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Color(Data.division[index].colorCode).withOpacity(.5),
                BlendMode.hardLight,
              ),
            ),
          ),
          child: Center(
            child: Text(
              Data.division[index].name,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.white,
              ),
            ),
          ),
        ),
      );
}
