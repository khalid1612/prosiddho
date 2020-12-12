import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prosiddho/constant/constant_export.dart';

class HomeCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _categoryCard("Food", FontAwesomeIcons.utensils),
        _categoryCard("Clothes", FontAwesomeIcons.tshirt),
        _categoryCard("Material", FontAwesomeIcons.radiationAlt),
        _categoryCard("Others", FontAwesomeIcons.braille),
      ],
    );
  }

  Widget _categoryCard(String text, IconData icon) {
    return SizedBox(
      width: Util.getProportionateScreenHeight(55),
      child: Column(
        children: [
          //icon
          AspectRatio(
            aspectRatio: 1.0,
            child: Container(
              padding: EdgeInsets.all(Util.getProportionateScreenHeight(15)),
              decoration: BoxDecoration(
                color: Color(0xFFFFECDF),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon),
            ),
          ),

          //space
          SizedBox(height: 5),

          //name
          Text(
            text,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
