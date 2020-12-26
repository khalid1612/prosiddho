import 'package:flutter/material.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/model/product_model/product_model.dart';

class CartModelProductDetails {
  //product id, quantity, added time
  CartModelProduct cartModelProduct;

  //product details
  ProductModel productModel;

  //total price per product
  double totalPrice;

  //buy get
  //extra -> how many item give extra
  int extra;

  CartModelProductDetails({
    @required this.cartModelProduct,
    @required this.productModel,
    @required this.totalPrice,
    @required this.extra,
  });
}
