import 'package:flutter/material.dart';

import 'menu_item.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          //profile
          MenuItem(index: 1),

          //my cart
          MenuItem(index: 2),

          //wishlist
          MenuItem(index: 3),

          //my orders
          MenuItem(index: 4),

          //verify product
          MenuItem(index: 5),

          //settings
          MenuItem(index: 6),
        ],
      ),
    );
  }
}
