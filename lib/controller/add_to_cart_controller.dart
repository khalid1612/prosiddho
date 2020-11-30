import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/state_manager.dart';
import 'package:prosiddho/controller/user_controller.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_create_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_read_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_update_function.dart';
import 'package:prosiddho/functions/firestore_crud/firestore_delete_function.dart';
import 'package:get/get.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/model/cart_model/cart_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';
import 'package:prosiddho/constant/utils.dart';

class AddToCartController extends GetxController {
  List<CartModelProductDetails> cartProducts =
      List<CartModelProductDetails>().obs;

  double get totalPriceWithoutCoupon =>
      cartProducts.fold(0, (total, item) => total + item.totalPrice);

  Future<void> addToCart(ProductModel productModel, {int quantity}) async {
    CartModelProduct newItem = CartModelProduct(
      addedTime: Timestamp.now(),
      productId: productModel.id,
      quantity: quantity ?? productModel.minimumOrder,
    );

    cartProducts.isEmpty
        ? await FirestoreCreateFunction.addTocart(newItem)
        : await FirestoreUpdateFunction.addTocart(newItem);
  }

  Future<void> addQuantity(int index, String productId) async {
    _controlQuantity(index, productId, 1);
  }

  Future<void> removeQuantity(int index, String productId) async {
    // TODO set a sleart for minimum order
    _controlQuantity(index, productId, -1);
  }

  Future<void> _controlQuantity(
    int index,
    String productId,
    int quantity,
  ) async {
    if (cartProducts[index].productModel.id == productId) {
      //increase quantity
      //remove item
      List<CartModelProductDetails> tempCartProducts = this.cartProducts;
      tempCartProducts[index].cartModelProduct.quantity += quantity;

      await FirestoreUpdateFunction.itemQuanity(tempCartProducts);
    }
  }

  Future<void> removeFromCart(int index, productId) async {
    if (cartProducts[index].productModel.id == productId) {
      //remove item
      List<CartModelProductDetails> tempCartProducts = this.cartProducts;
      tempCartProducts.removeAt(index);

      //last item on cart then delete the document otherwise update
      cartProducts.length == 0
          ? await FirestoreDeleteFunction.cart()
          : await FirestoreUpdateFunction.removeFromcart(tempCartProducts);
    }
  }

  Future startCartStream() async {
    FirestoreReadFunction.cartStream(Get.find<UserController>().userModel.id)
        .listen((DocumentSnapshot document) async {
      print("call");
      if (document.exists) {
        //clear cartProducts
        cartProducts.clear();

        //update cart model
        CartModel cartModel = CartModel.fromFirestore(document);

        //collect all product ids already in cart (ii)
        List<CartModelProduct> tempProductId = cartModel.cartModelProduct;

        for (ProductModel productModel
            in Get.find<ProductController>().allProducts) {
          for (int i = 0, j = tempProductId.length; i < j; i++) {
            if (productModel.id == tempProductId[i].productId) {
              cartProducts.add(
                CartModelProductDetails(
                  cartModelProduct: tempProductId[i],
                  productModel: productModel,
                  totalPrice: 0.0,
                  extra: 0,
                ),
              );

              //calculate price
              cartProducts[cartProducts.length - 1].totalPrice =
                  Util.priceCalculate(cartProducts[cartProducts.length - 1]);

              //calcualte extra
              if (productModel.buyGet.extra != null &&
                  productModel.buyGet.extra != 0 &&
                  productModel.buyGet.quantity != null &&
                  productModel.buyGet.quantity != 0) {
                cartProducts[cartProducts.length - 1].extra =
                    ((tempProductId[i].quantity /
                                productModel.buyGet.quantity) *
                            productModel.buyGet.extra)
                        .floor();
              }

              tempProductId.removeAt(i);
              break;
            }
          }
          if (tempProductId == null || tempProductId.length == 0) {
            break;
          }
        }
      }
      //remove later

      else {
        print('i am out');
      }
    });
  }

  void reset() {
    this.cartProducts.clear();
  }
}
