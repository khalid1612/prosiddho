import 'package:flutter/material.dart';

import 'menu/menu_screen.dart';
import 'home/home_screen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          MenuScreen(),
          HomeScreen(),
        ],
      ),
    );
  }
}
