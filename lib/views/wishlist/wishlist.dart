import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/constant/constant_export.dart';

import 'package:prosiddho/style/style_export.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WishlistScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text("Wishlist"),
        centerTitle: true,
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
      body: SingleChildScrollView(
        child: Padding(
          padding: Style.marginBase,
          child: Obx(() {
            WishlistController _wishlistController =
                Get.find<WishlistController>();

            return Column(
              children: [
                ...List.generate(
                  Get.find<WishlistController>().count,
                  (index) {
                    var _productDetails = Get.find<ProductController>()
                        .findProduct(_wishlistController.wishlistIds[index]);

                    bool isInCart = Get.find<AddToCartController>()
                        .isProductInCart(_productDetails);
                    return Container(
                      padding: Style.marginBase / 2,
                      margin: EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: Style.borderRadius,
                        color: ColorPalette.bg.withOpacity(.1),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //!image get extra
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
                                      "Buy: ${_productDetails.buyGet.quantity}  Get: ${_productDetails.buyGet.extra}",
                                      style: TextStyle(
                                        color: Colors.green,
                                      ),
                                    ),

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

                                        if (_productDetails.offerPercent !=
                                                null &&
                                            _productDetails.offerPercent != 0)
                                          Spacer(),

                                        if (!isInCart)
                                          GestureDetector(
                                            onTap: () {
                                              Get.find<AddToCartController>()
                                                  .addToCart(_productDetails);
                                            },
                                            child: Container(
                                              height: 25,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 5,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  color: Colors.blue,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  "Add To Cart",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    color: Colors.blue,
                                                  ),
                                                ),
                                              ),
                                            ),
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
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
