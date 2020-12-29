import 'package:flutter/material.dart';
import 'home_search_field.dart';
import 'package:get/get.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/views/cart/cart_screen.dart';
import 'package:prosiddho/style/style_export.dart';

class HomeHeader extends StatelessWidget {
  final bool isDrawerOpen;

  const HomeHeader({
    Key key,
    @required this.isDrawerOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchField(isDrawerOpen: isDrawerOpen),

        //bag icon
        Obx(
          () => Buttons.iconButtonWithCounter(
            iconData: FontAwesomeIcons.shoppingCart,
            numOfitem: Get.find<AddToCartController>().itemInCart,
            press: () => Get.to(CartScreen()),
          ),
        ),

        //notification icon
        // IconBtnWithCounter(
        //   iconData: FontAwesomeIcons.solidBell,
        //   numOfitem: 3,
        //   press: () {},
        // ),
      ],
    );
  }
}
