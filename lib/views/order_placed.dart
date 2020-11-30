import 'package:flutter/material.dart';

class OrderPlaced extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Text("Thank you"),
          RaisedButton(
            onPressed: () {},
            child: Text("Finish"),
          ),
        ],
      ),
    );
  }
}
