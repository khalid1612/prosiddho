import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';
import 'package:prosiddho/style/style_export.dart';

import 'local_widget/profile_user_basic.dart';
import 'local_widget/profile_user_rewards.dart';
import 'local_widget/profile_user_info.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            //user basic
            ProfileUserBasic(),

            //rewards titel
            Padding(
              padding: Style.marginBase.copyWith(bottom: Style.margin / 2),
              child: Text(
                "Rewards",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //rewords
            ProfileUserRewards(),

            //accounts title
            Padding(
              padding: Style.marginBase.copyWith(bottom: Style.margin / 2),
              child: Text(
                "Accounts",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            //user info or accounts body
            ProfileUserInfo(),
          ],
        ),
      ),
    );
  }
}
