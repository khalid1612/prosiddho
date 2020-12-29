import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:prosiddho/constant/database_helper.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  List<ProductModel> allProducts = List<ProductModel>().obs;

  int get totalProducts => allProducts.length;

  bool freeDeliveryAvailable() {
    for (ProductModel productModel in allProducts) {
      if (productModel.offerPercent != null && productModel.offerPercent > 0) {
        return true;
      }
    }
    return false;
  }

  ProductModel findProduct(String productId) {
    for (int i = 0; i < totalProducts; i++) {
      if (allProducts[i].id == productId) {
        return allProducts[i];
      }
    }
    return null;
  }

  Future fetchProduct() async {
    await DatabaseHelper.collectionProductDetails
        .get()
        .then((QuerySnapshot documents) async {
      if (documents.size > 0) {
        List<ProductModel> products = List();
        documents.docs.forEach((QueryDocumentSnapshot document) {
          products.add(ProductModel.fromFirestore(
            queryDocumentSnapshot: document,
          ));
        });

        this.allProducts = products;
        print("product fetch successfully");

        final AddToCartController _addToCartController =
            Get.put(AddToCartController());
        await _addToCartController.startCartStream();
      }
    });
  }
}
