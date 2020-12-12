import 'package:flutter/material.dart';
import 'home_icon_btn_with_counter.dart';
import 'home_search_field.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SearchField(),

        //bag icon
        IconBtnWithCounter(
          iconData: Icons.shop,
          press: () {},
        ),

        //notification icon
        IconBtnWithCounter(
          iconData: Icons.notification_important,
          numOfitem: 3,
          press: () {},
        ),
      ],
    );
  }
}
