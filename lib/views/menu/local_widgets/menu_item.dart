import 'package:flutter/material.dart';
import 'package:prosiddho/data/data.dart';
import 'package:prosiddho/style/style.dart';

class MenuItem extends StatelessWidget {
  final int index;

  const MenuItem({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Data.menu[index].onTap,
      child: Container(
        padding: Style.paddingVertically / 4,
        child: Row(
          children: [
            Icon(
              Data.menu[index].icon,
              color: Colors.white54,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              Data.menu[index].name,
              style: TextStyle(
                fontSize: 22,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
