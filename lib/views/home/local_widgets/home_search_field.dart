import 'package:flutter/material.dart';
import 'package:prosiddho/style/color_palette.dart';

class SearchField extends StatelessWidget {
  final bool isDrawerOpen;

  const SearchField({
    Key key,
    @required this.isDrawerOpen,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: ColorPalette.bg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: TextField(
          onChanged: (value) => print(value),
          decoration: InputDecoration(
            border: InputBorder.none,
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            hintText: "Search product",
            prefixIcon: Icon(Icons.search),
            enabled: isDrawerOpen ? false : true,
          ),
        ),
      ),
    );
  }
}
