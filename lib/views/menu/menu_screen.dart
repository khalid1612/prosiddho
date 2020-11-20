import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style.dart';

import 'local_widgets/menu_footer.dart';
import 'local_widgets/menu_header.dart';
import 'local_widgets/menu_list.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  Widget _divider() => Container(
        width: 150,
        height: 1,
        color: Colors.white30,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorPalette.primaryPurple,
      body: Container(
        margin: Style.marginHorizontally,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MenuHeader(),
            MenuList(),
            _divider(),
            MenuFooter(),
          ],
        ),
      ),
    );
  }
}
