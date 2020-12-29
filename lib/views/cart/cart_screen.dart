import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';
import 'package:prosiddho/model/cart_model/cart_model_product.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/checkout/checkout_screen.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CartScreen extends StatelessWidget {
  final AddToCartController _addToCartController =
      Get.find<AddToCartController>();

  int itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        actions: [
          //bag icon
          Padding(
            padding: Style.paddingHorizontally,
            child: Center(
              child: Obx(
                () => Buttons.iconButtonWithCounter(
                  iconData: FontAwesomeIcons.shoppingCart,
                  numOfitem: Get.find<AddToCartController>().itemInCart,
                  press: () => null,
                  bgColor: Colors.white,
                  size: 30,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () {
          itemCount = _addToCartController.cartProducts.length;

          return itemCount == 0
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Icon(
                        FontAwesomeIcons.sadTear,
                        size: 100,
                        color: ColorPalette.secondary.withOpacity(.5),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: Text(
                          "No Item Found",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: itemCount,
                  itemBuilder: (context, index) {
                    CartModelProductDetails item =
                        _addToCartController.cartProducts[index];

                    ProductModel _productDetails = item.productModel;

                    CartModelProduct _product = item.cartModelProduct;

                    //ui
                    return Container(
                      margin: Style.marginBase
                          .copyWith(bottom: index == itemCount - 1 ? 15 : 0),
                      padding: Style.marginBase / 2.5,
                      decoration: BoxDecoration(
                        borderRadius: Style.borderRadius,
                        color: Colors.white,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //!image get extra
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //image
                              Container(
                                height: Util.getProportionateScreenHeight(80),
                                width: Util.getProportionateScreenWidth(80),
                                decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: _productDetails.imageLink.length > 0
                                    ? ImageLoading.cachedNetworkImage(
                                        _productDetails.imageLink[0],
                                        radius: 10,
                                      )
                                    : Container(),
                              ),

                              SizedBox(height: 5),

                              //extra
                              if (item.extra > 0)
                                Container(
                                  width: Util.getProportionateScreenWidth(80),
                                  padding: Style.marginBase / 3,
                                  decoration: BoxDecoration(
                                    color: ColorPalette.bg.withOpacity(.1),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text.rich(
                                      TextSpan(text: "FREE  ", children: [
                                        TextSpan(
                                          text: "${item.extra}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                        TextSpan(
                                            text: "  ${_productDetails.unit}"),
                                      ]),
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          //!details
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.only(left: 10),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //name
                                    Text(
                                      _productDetails.name.capitalize,
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),

                                    //price
                                    PriceStyle.priceStyle(
                                      regular: _productDetails.price,
                                      offer: _productDetails.priceOffer,
                                      fontSize: 16,
                                    ),

                                    //min order
                                    Text(
                                        "Min Order: ${_productDetails.minimumOrder} ${_productDetails.unit}"),

                                    Row(
                                      children: [
                                        //offerPercent
                                        if (_productDetails.offerPercent !=
                                                null &&
                                            _productDetails.offerPercent != 0)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              vertical: 2,
                                              horizontal: 10,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              vertical: 5,
                                            ).copyWith(right: 10),
                                            decoration: BoxDecoration(
                                              color: ColorPalette.primary,
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              "Discount: ${_productDetails.offerPercent}%",
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),

                                        //buy get
                                        if (_productDetails.buyGet.quantity !=
                                            null)
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 10.0,
                                              vertical: 2.0,
                                            ),
                                            margin: EdgeInsets.symmetric(
                                              vertical: 5,
                                            ).copyWith(right: 10),
                                            decoration: BoxDecoration(
                                              color:
                                                  Colors.green.withOpacity(.1),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                            child: Obx(() {
                                              int buyP = _addToCartController
                                                  .cartProducts[index]
                                                  .productModel
                                                  .buyGet
                                                  .quantity;

                                              int getP = _addToCartController
                                                  .cartProducts[index]
                                                  .productModel
                                                  .buyGet
                                                  .extra;

                                              int currentExtra =
                                                  _addToCartController
                                                          .cartProducts[index]
                                                          .extra ??
                                                      0;

                                              buyP = buyP * (currentExtra + 1);
                                              getP = getP * (currentExtra + 1);

                                              return Text(
                                                "Buy: $buyP  Get: $getP",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.green,
                                                ),
                                              );
                                            }),
                                          ),
                                      ],
                                    ),

                                    SizedBox(height: 10),

                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        //total price
                                        Text(
                                          Values.tkSign +
                                              item.totalPrice
                                                  .toStringAsFixed(1),
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),

                                        SizedBox(width: 25),

                                        //remove button
                                        GestureDetector(
                                          onTap: () {
                                            _addToCartController.removeQuantity(
                                              index,
                                              _product.productId,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                              ),
                                            ),
                                            child: Icon(Icons.remove),
                                          ),
                                        ),

                                        //quantity
                                        Container(
                                          height: 26,
                                          width: 24,
                                          decoration: BoxDecoration(
                                            border: Border(
                                              top: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                              ),
                                              bottom: BorderSide(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                              ),
                                            ),
                                          ),
                                          child: Center(
                                            child: Obx(
                                              () => Text(
                                                _addToCartController
                                                    .cartProducts[index]
                                                    .cartModelProduct
                                                    .quantity
                                                    .toString(),
                                              ),
                                            ),
                                          ),
                                        ),

                                        //add button
                                        GestureDetector(
                                          onTap: () {
                                            _addToCartController.addQuantity(
                                              index,
                                              _product.productId,
                                            );
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black
                                                    .withOpacity(.1),
                                              ),
                                            ),
                                            child: Icon(Icons.add),
                                          ),
                                        ),

                                        Spacer(),

                                        //remove item from cart button
                                        Buttons.roundedIconBtn(
                                          FontAwesomeIcons.trash,
                                          () => _addToCartController
                                              .removeFromCart(
                                            _productDetails.id,
                                          ),
                                          bgColor: ColorPalette.primaryRed
                                              .withOpacity(.1),
                                          iconColor: ColorPalette.primaryRed,
                                          showShadow: true,
                                        ),
                                      ],
                                    ),
                                  ]),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
        },
      ),

      //bottom navigation bar

      bottomNavigationBar: Obx(
        () => _addToCartController.cartProducts.length == 0
            ? BottomAppBar()
            : BottomNavigation(
                child: Padding(
                  padding: Style.marginVertically / 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Obx(
                            () => Text(
                              Values.tkSign +
                                  _addToCartController.totalPriceWithoutCoupon
                                      .toStringAsFixed(2),
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Spacer(),

                          //Checkout button
                          GestureDetector(
                            onTap: () => Get.to(CheckoutScreen()),
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: Style.margin / 2.5,
                                horizontal: Style.margin,
                              ),
                              decoration: BoxDecoration(
                                color: ColorPalette.primary,
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Center(
                                child: Text(
                                  "Checkout",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorPalette.textLight,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}
