import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';

class FirestoreReadFunction {
  /*collect user details from database*/
  static Future<UserModel> user(String userID) async {
    UserModel userModel;

    await DatabaseHelper.collectionUsers
        .doc(userID)
        .get()
        .then((DocumentSnapshot data) async {
      if (data.exists) {
        userModel = UserModel.fromFirestore(data);
      }
    }).catchError((error) => print("user get failed: $error"));

    return userModel;
  }

  //user stream
  static Stream<DocumentSnapshot> userStream(String userID) {
    return DatabaseHelper.collectionUsers.doc(userID).snapshots();
  }

  /*collect settins from database*/
  static Future<AdminSettings> settings() async {
    AdminSettings settings;

    await DatabaseHelper.collectionSettings
        .doc("6OOmeARkJEECXm3arCLX")
        .get()
        .then((DocumentSnapshot data) async {
      if (data.exists) {
        settings = AdminSettings.fromFirestore(data);
      }
    }).catchError((error) => print("Settings fetch error: $error"));

    return settings;
  }

  /*collect settins from database*/
  static Future<List<ProductModel>> products() async {
    List<ProductModel> productList = List();

    await DatabaseHelper.collectionProductDetails
        .get()
        .then((QuerySnapshot data) async {
      if (data.size > 0) {
        data.docs.forEach((QueryDocumentSnapshot doc) {
          ProductModel productModel =
              ProductModel.fromFirestore(queryDocumentSnapshot: doc);
          productList.add(productModel);
        });
      }
    }).catchError((error) => print("Get settings error: $error"));

    return productList;
  }
}
