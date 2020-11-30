import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/views/checkout/checkout_screen.dart';

class CartScreen extends StatelessWidget {
  final AddToCartController _addToCartController =
      Get.find<AddToCartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(
        () {
          int len = _addToCartController.cartProducts.length;

          return len == 0
              ? Text("no item")
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: len,
                  itemBuilder: (context, index) {
                    CartModelProductDetails item =
                        _addToCartController.cartProducts[index];

                    ProductModel _productDetails =
                        _addToCartController.cartProducts[index].productModel;

                    CartModelProduct _product = _addToCartController
                        .cartProducts[index].cartModelProduct;

                    //ui
                    return Container(
                      color: Colors.grey,
                      margin: EdgeInsets.all(20),
                      padding: EdgeInsets.all(20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          //name
                          Text(_productDetails.name),

                          //price
                          Text("regular price: ${_productDetails.price}"),
                          Text("offer price: ${_productDetails.priceOffer}"),
                          Text("total price: ${item.totalPrice}"),

                          //min order
                          Text("min order: ${_productDetails.minimumOrder}"),

                          //offerPercent
                          Text("offerPercent: ${_productDetails.offerPercent}"),

                          //extra details
                          Text(
                              "buy: ${_productDetails.buyGet.quantity} get: ${_productDetails.buyGet.extra}"),

                          //extra
                          Text("extra ${item.extra}"),

                          //qunatity controller
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              //-
                              RaisedButton(
                                onPressed: () {
                                  _addToCartController.removeQuantity(
                                    index,
                                    _product.productId,
                                  );
                                },
                                child: Text("-"),
                              ),

                              //quantity
                              Text(_product.quantity.toString()),

                              //+
                              RaisedButton(
                                onPressed: () {
                                  _addToCartController.addQuantity(
                                    index,
                                    _product.productId,
                                  );
                                },
                                child: Text("+"),
                              ),
                            ],
                          ),

                          //remove
                          RaisedButton(
                            onPressed: () {
                              _addToCartController.removeFromCart(
                                index,
                                _productDetails.id,
                              );
                            },
                            child: Text("remove"),
                          )
                        ],
                      ),
                    );
                  },
                );
        },
      ),

      //bottom navigation bar
      bottomNavigationBar: BottomAppBar(
        color: Colors.amber,
        shape: CircularNotchedRectangle(),
        child: Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Obx(() => Text(
                  "${_addToCartController.totalPriceWithoutCoupon.toString()}")),
              Spacer(),
              RaisedButton(
                onPressed: () => Get.to(CheckoutScreen()),
                child: Text("Checkout"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
