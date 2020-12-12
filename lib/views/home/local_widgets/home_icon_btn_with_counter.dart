import 'package:flutter/material.dart';
import 'package:prosiddho/constant/utils.dart';
import 'package:prosiddho/style/color_palette.dart';

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key key,
    @required this.iconData,
    this.numOfitem = 0,
    @required this.press,
  }) : super(key: key);

  final IconData iconData;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            padding: EdgeInsets.all(Util.getProportionateScreenWidth(10)),
            margin: EdgeInsets.only(left: Util.getProportionateScreenWidth(2)),
            height: Util.getProportionateScreenWidth(46),
            width: Util.getProportionateScreenWidth(46),
            decoration: BoxDecoration(
              color: ColorPalette.bg.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(iconData),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: Util.getProportionateScreenWidth(16),
                width: Util.getProportionateScreenWidth(16),
                decoration: BoxDecoration(
                  color: Color(0xFFFF4848),
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: TextStyle(
                      fontSize: Util.getProportionateScreenWidth(10),
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
        ],
      ),
    );
  }
}
