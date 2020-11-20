import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/enum/status.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';
import 'package:prosiddho/model/user_model/user_model.dart';
import 'package:prosiddho/views/dashboard_screen.dart';

class UserController extends GetxController {
  Rx<UserModel> _userModel = UserModel.init().obs;

  bool _initSetupFinish = false;

  UserModel get userModel => this._userModel.value;

  set userModel(UserModel user) => this._userModel.value = user;

  void reset() {
    this._userModel.value = UserModel.init();
  }

  //start a user stream
  //bacause if user change  phone or address or
  //user used a  free delivery or earn points or
  //make an order then it will update automatically
  void startUserStream(String userID) async {
    FirestoreReadFunction.userStream(userID)
        .listen((DocumentSnapshot document) async {
      //if user already registered and data available
      //update user model and continue

      //check document  exists for sefty
      if (document.exists) {
        UserModel userModel = UserModel.fromFirestore(document);

        //check user status
        if (userModel.accountStatus.status == Status.Active.value) {
          //set initial setup
          if (!_initSetupFinish) {
            _initSetupFinish = true;

            this.userModel = userModel;

            //check last sign in
            //if user back from long time (date available in adimn settings)
            //check offer and update database;

            await FirestoreUpdateFunction.offerUpdate();

            //update last signin
            await FirestoreUpdateFunction.lastLogin(userID);

            //collect all products initially ;
            //so that categorize all products easily
            ProductController _productController = Get.put(ProductController());
            await _productController.fetchProduct();

            //go to homne page
            Get.to(DashboardScreen());
          }
        } else {
          Get.defaultDialog(
            title: "Your account is ${userModel.accountStatus.status}",
          );
          // await FirestoreUpdateFunction.lastLogin(userID);

        }
      }
    });
  }
}
