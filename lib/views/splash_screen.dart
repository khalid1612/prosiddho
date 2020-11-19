import 'package:flutter/material.dart';
import 'package:prosiddho/style/style.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(
          "Prosiddho",
          style: Style.heading1,
        ),
      ),
    );
  }
}
