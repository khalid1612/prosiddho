import 'package:flutter/material.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:get/get.dart';

class HomeHotProduct extends StatelessWidget {
  final ProductController _productController = Get.find<ProductController>();
  final AddToCartController _addToCartController =
      Get.find<AddToCartController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _productController.allProducts.length,
        itemBuilder: (context, index) {
          return Container(
            height: 300,
            width: 200,
            color: Colors.white70,
            margin: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(_productController.allProducts[index].name),
                Text(_productController.allProducts[index].unit),
                Text("price ${_productController.allProducts[index].price}"),
                Text(
                    "price offer ${_productController.allProducts[index].priceOffer}"),
                Text(
                    "offer percent ${_productController.allProducts[index].offerPercent}"),
                Text("stock ${_productController.allProducts[index].stock}"),
                Text(
                    "min order ${_productController.allProducts[index].minimumOrder}"),
                Text(
                    "min order offer ${_productController.allProducts[index].minimumOrderOffer}"),
                Text(
                    "buy ${_productController.allProducts[index].buyGet.quantity}"),
                Text(
                    "get ${_productController.allProducts[index].buyGet.extra}"),
                RaisedButton(
                  onPressed: () {
                    _addToCartController
                        .addToCart(_productController.allProducts[index]);
                  },
                  child: Text("add to cart"),
                ),
                RaisedButton(
                  onPressed: () {
                    Get.find<WishlistController>().addToWishlist(
                        _productController.allProducts[index].id);
                  },
                  child: Text("add to Wishlist"),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
