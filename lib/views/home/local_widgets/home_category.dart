import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/category/category_screen.dart';
import 'package:get/get.dart';

class HomeCategory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: 30,
        bottom: 20,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _categoryCard("Food", FontAwesomeIcons.utensils),
          _categoryCard("Clothes", FontAwesomeIcons.tshirt),
          _categoryCard("Material", FontAwesomeIcons.radiationAlt),
          _categoryCard("Others", FontAwesomeIcons.braille),
        ],
      ),
    );
  }

  Widget _categoryCard(String text, IconData icon) {
    return SizedBox(
      width: Util.getProportionateScreenHeight(55),
      child: Column(
        children: [
          //icon
          GestureDetector(
            onTap: () => Get.to(CategoryScreen(categoryName: text)),
            child: AspectRatio(
              aspectRatio: 1.0,
              child: Container(
                decoration: BoxDecoration(
                  color: ColorPalette.primaryPurple,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                ),
              ),
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
