import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/model/order_model/order_model.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/model/user_model/user_model.dart';
import 'package:prosiddho/model/cart_model/cart_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/controller/user_controller.dart';

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

    // !try it later (more efficient)
    // DatabaseHelper.collectionSettings.get().then((QuerySnapshot documents) {
    //   if (documents.size == 1) {
    //     documents.docs.forEach((QueryDocumentSnapshot document) {
    //       AdminSettings adminSettings = AdminSettings.fromFirestore(document);
    //       _adminController.adminSettings = adminSettings;
    //     });

    //     _startUserStream();
    //   }
    // });
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

  //payment
  static Stream<DocumentSnapshot> paymentStream() {
    return DatabaseHelper.collectionPayment
        .doc(Get.find<UserController>().userModel.id)
        .snapshots();
  }

//user stream
  static Stream<DocumentSnapshot> cartStream(String userID) {
    return DatabaseHelper.collectionCart.doc(userID).snapshots();
  }

  /*collect settins from database*/
  static Future<List<ProductModel>> cart(String userID) async {
    List<ProductModel> productList = List();

    await DatabaseHelper.collectionCart
        .doc(userID)
        .get()
        .then((DocumentSnapshot data) {
      if (data.exists) {
        final CartModel cartModel = CartModel.fromFirestore(data);
        final List<ProductModel> productIds =
            Get.find<ProductController>().allProducts;

        List<CartModelProduct> tempProductId = cartModel.cartModelProduct;

        for (ProductModel productModel in productIds) {
          for (int i = 0, j = tempProductId.length; i < j; i++) {
            if (productModel.id == tempProductId[i].productId) {
              productList.add(productModel);
              tempProductId.removeAt(i);
              break;
            }
          }

          if (tempProductId == null || tempProductId.length == 0) {
            break;
          }
        }
      } else {
        productList = null;
      }
    }).catchError((error) => print("Get cart error: $error"));

    return productList;
  }

  static Future<List<OrderModel>> fetchOrders() async {
    List<OrderModel> tempOrderModel = List();

    await DatabaseHelper.collectionOrder
        .where('user_id', isEqualTo: Get.find<UserController>().userModel.id)
        .get()
        .then((QuerySnapshot documents) {
      documents.docs.forEach((doc) {
        tempOrderModel.add(OrderModel.fromFirestore(doc));
      });
    }).catchError((error) => print("Order fetch error: $error"));

    return tempOrderModel;
  }
}
