import 'package:flutter/material.dart';
import 'package:prosiddho/style/style.dart';

import 'menu_item.dart';

class MenuFooter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: Style.marginVertically.copyWith(top: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          MenuItem(index: 8),
          MenuItem(index: 7),
        ],
      ),
    );
  }
}
