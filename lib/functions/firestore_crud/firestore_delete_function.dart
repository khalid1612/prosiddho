import 'package:prosiddho/constant/database_helper.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/user_controller.dart';

class FirestoreDeleteFunction {
  static Future cart() async {
    DatabaseHelper.collectionCart
        .doc(Get.find<UserController>().userModel.id)
        .delete()
        .then((value) => print("cart Deleted"))
        .catchError((error) => print("Failed to delete cart: $error"));
  }
}
