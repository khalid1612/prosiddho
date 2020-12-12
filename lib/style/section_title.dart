import 'package:flutter/material.dart';
import 'package:prosiddho/constant/utils.dart';
import 'package:prosiddho/style/style.dart';
import 'package:prosiddho/style/color_palette.dart';

class SectionTitle extends StatelessWidget {
  final String title;
  final String subTitle;
  final bool showMore;
  final String showMoreText;
  final Function onMoreTap;
  final EdgeInsets margin;

  const SectionTitle({
    Key key,
    @required this.title,
    this.subTitle,
    this.showMore = true,
    this.showMoreText = "See More",
    this.onMoreTap,
    this.margin,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? Style.marginBase.copyWith(bottom: Style.margin / 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //title
              Text(
                title,
                style: TextStyle(
                  fontSize: Util.getProportionateScreenWidth(18),
                  color: ColorPalette.text,
                ),
              ),

              //subtitle
              if (subTitle != null)
                Text(
                  subTitle,
                  style: TextStyle(
                    fontSize: Util.getProportionateScreenWidth(9),
                    color: ColorPalette.text,
                  ),
                ),
            ],
          ),
          if (showMore)
            GestureDetector(
              onTap: onMoreTap,
              child: Text(
                showMoreText,
                style: TextStyle(color: Color(0xFFBBBBBB)),
              ),
            ),
        ],
      ),
    );
  }
}
