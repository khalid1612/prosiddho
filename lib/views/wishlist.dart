import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Text(
          Get.find<WishlistController>().count.toString(),
        ),
      ),
    );
  }
}
