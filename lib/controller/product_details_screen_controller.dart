import 'package:get/state_manager.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';
import 'package:prosiddho/constant/constant_export.dart';

class ProductDetailsScreenController extends GetxController {
  RxInt _quantity = 0.obs;
  RxDouble _totalPrice = 0.0.obs;
  int _minimumOrder = 0;
  ProductModel _product;

  int get quantity => _quantity.value;
  double get totalPrice => _totalPrice.value;

  void addQuantity() {
    this._quantity.value = this.quantity + 1;
    // update price
    calculatePrice();
  }

  void removeQuantity() {
    if (this.quantity - 1 >= _minimumOrder) {
      _quantity.value = this.quantity - 1;

      // update price
      calculatePrice();
    }
  }

  void init(ProductModel product) {
    //minimum order
    _quantity.value = _minimumOrder = product.priceOffer == 0
        ? product.minimumOrder
        : product.minimumOrderOffer;

    //set product model
    _product = product;

    // set total price
    calculatePrice();
  }

  void reset() {
    this._quantity.value = 0;
    this._totalPrice.value = 0.0;
    this._minimumOrder = 0;
  }

  void calculatePrice() {
    _totalPrice.value = Util.priceCalculate(
      CartModelProductDetails(
        cartModelProduct: CartModelProduct(
          productId: _product.id,
          quantity: this.quantity,
          addedTime: null,
        ),
        productModel: _product,
        totalPrice: null,
        extra: null,
      ),
    );
  }
}
