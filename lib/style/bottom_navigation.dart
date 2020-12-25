import 'package:flutter/material.dart';

class BottomNavigation extends StatelessWidget {
  final Widget child;

  const BottomNavigation({
    Key key,
    @required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 0.0,
      color: Colors.white,
      shape: CircularNotchedRectangle(),
      child: Container(
        padding: EdgeInsets.all(20),
        child: this.child,
      ),
    );
  }
}
