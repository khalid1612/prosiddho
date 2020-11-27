import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/style/style.dart';
import 'package:get/get.dart';
import '../cart/cart_screen.dart';

import 'local_widgets/home_division.dart';
import 'local_widgets/home_search.dart';
import 'local_widgets/home_hot_product.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;

  bool isDrawerOpen = false;

  Widget _appbar() {
    return Container(
      margin: Style.marginAppbar,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          //menu icon and back icon
          isDrawerOpen
              ? IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    setState(() {
                      xOffset = 0;
                      yOffset = 0;
                      scaleFactor = 1;
                      isDrawerOpen = false;
                    });
                  },
                )
              : IconButton(
                  icon: Icon(Icons.menu),
                  onPressed: () {
                    setState(() {
                      xOffset = 250;
                      yOffset = 150;
                      scaleFactor = 0.6;
                      isDrawerOpen = true;
                    });
                  }),

          //cart icon
          IconButton(
            onPressed: () {
              Get.to(CartScreen());
            },
            icon: Icon(EvaIcons.shoppingCartOutline),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      transform: Matrix4.translationValues(xOffset, yOffset, 0)
        ..scale(scaleFactor)
        ..rotateY(isDrawerOpen ? -0.5 : 0)
        ..rotateX(isDrawerOpen ? -0.08 : 0)
        ..rotateZ(isDrawerOpen ? -0.08 : 0),
      duration: Duration(milliseconds: 250),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(
          isDrawerOpen ? 40 : 0.0,
        ),
      ),
      child: Column(
        children: [
          _appbar(),
          HomeSearch(),
          // !Heading(
          //   title: "Division",
          //   marginTop: 30,
          //   marginBottom: 0,
          //   more: true,
          // ),
          HomeDivision(),
          HomeHotProduct(),
        ],
      ),
    );
  }
}
