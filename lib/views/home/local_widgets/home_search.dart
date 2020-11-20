import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style.dart';

class HomeSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: Style.paddingBase,
      margin: Style.marginHorizontally.copyWith(top: Style.margin),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: TextField(
              style: TextStyle(
                fontSize: 18,
                color: ColorPalette.text,
              ),
              decoration: InputDecoration.collapsed(
                hintText: 'Search Your Product',
                hintStyle: TextStyle(
                  fontSize: 18,
                  color: const Color(0xff818181),
                  letterSpacing: -0.4341176147460938,
                ),
              ),
            ),
          ),
          Icon(Icons.settings)
        ],
      ),
    );
  }
}
