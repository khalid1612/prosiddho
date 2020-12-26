import 'package:get/state_manager.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_create_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';

class WishlistController extends GetxController {
  List<String> wishlistIds = List<String>().obs;

  int get count => this.wishlistIds.length;

  Future addToWishlist(String productId) async {
    if (wishlistIds.contains(productId)) {
      await FirestoreUpdateFunction.addToWishlist(productId);
      print("remove form wishlist");
    } else {
      await FirestoreCreateFunction.addToWishlist(productId);
      print("add in wishlist");
    }
  }

  Future startStream() async {
    DatabaseHelper.collectionWishlist
        .doc(Get.find<UserController>().userModel.id)
        .snapshots()
        .listen((DocumentSnapshot document) {
      if (document.exists) {
        wishlistIds.clear();

        int countIds = document['ids'].length ?? 0;

        if (countIds > 0) {
          for (int i = 0; i < countIds; i++) {
            wishlistIds.add(document['ids'][i]);
          }
        }
      } else {
        print('i am out');
      }
    });
  }
}
