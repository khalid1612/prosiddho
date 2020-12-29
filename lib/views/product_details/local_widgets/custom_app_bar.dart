import 'package:flutter/material.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/style/style_export.dart';

class CustomAppBar extends PreferredSize {
  final double rating;

  CustomAppBar({@required this.rating});

  @override
  // AppBar().preferredSize.height provide us the height that appy on our app bar
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height + 60);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: Util.getProportionateScreenWidth(20),
          // vertical: Util.getProportionateScreenHeight(20),
        ),
        // margin: Style.marginVertically,
        decoration: BoxDecoration(
          color: Colors.amber,
        ),
        child: Row(
          children: [
            SizedBox(
              height: Util.getProportionateScreenWidth(40),
              width: Util.getProportionateScreenWidth(40),
              child: FlatButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(60),
                ),
                color: Colors.white,
                padding: EdgeInsets.zero,
                onPressed: () => Navigator.pop(context),
                child: Icon(Icons.arrow_back),
              ),
            ),
            Spacer(),
            // Container(
            //   padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
            //   decoration: BoxDecoration(
            //     color: Colors.white,
            //     borderRadius: BorderRadius.circular(14),
            //   ),
            //   child: Row(
            //     children: [
            //       Text(
            //         rating == null ? "0.0" : rating.toStringAsFixed(1),
            //         style: const TextStyle(
            //           fontSize: 14,
            //           fontWeight: FontWeight.w600,
            //         ),
            //       ),
            //       const SizedBox(width: 5),
            //       Icon(Icons.star),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
