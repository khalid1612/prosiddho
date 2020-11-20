import 'package:flutter/material.dart';

import 'menu_item.dart';

class MenuList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          MenuItem(index: 0),
          MenuItem(index: 1),
          MenuItem(index: 2),
          MenuItem(index: 3),
          MenuItem(index: 4),
          MenuItem(index: 5),
          MenuItem(index: 6),
        ],
      ),
    );
  }
}
