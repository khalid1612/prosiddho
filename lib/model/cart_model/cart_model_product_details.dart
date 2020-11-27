import 'package:flutter/material.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/model/product_model/product_model.dart';

class CartModelProductDetails {
  CartModelProduct cartModelProduct;
  ProductModel productModel;
  double totalPrice;
  int extra;

  CartModelProductDetails({
    @required this.cartModelProduct,
    @required this.productModel,
    @required this.totalPrice,
    @required this.extra,
  });
}
