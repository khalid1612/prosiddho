import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/product_details_screen_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/constant/constant_export.dart';

import 'package:prosiddho/views/cart/cart_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'local_widgets/product_images.dart';
import 'local_widgets/top_rounded_container.dart';
import 'local_widgets/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  ProductDetailsScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _detailsController = Get.put(ProductDetailsScreenController());
    _detailsController.init(product);

    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(100.0),
        child: AppBar(
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false, // hides leading widget
          flexibleSpace: SafeArea(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: Util.getProportionateScreenWidth(20),
                vertical: Util.getProportionateScreenHeight(20),
              ),
              child: Row(
                children: [
                  //back icon
                  SizedBox(
                    height: Util.getProportionateScreenWidth(40),
                    width: Util.getProportionateScreenWidth(40),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(60),
                      ),
                      color: Colors.white,
                      padding: EdgeInsets.zero,
                      onPressed: () => Navigator.pop(context),
                      child: Icon(Icons.arrow_back),
                    ),
                  ),

                  Spacer(),

                  //bag icon
                  Obx(
                    () => Buttons.iconButtonWithCounter(
                      iconData: FontAwesomeIcons.shoppingCart,
                      numOfitem: Get.find<AddToCartController>().itemInCart,
                      press: () => Get.to(CartScreen()),
                      bgColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          //produt images
          ProductImages(product: product),

          //details
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(product: product),
              ],
            ),
          ),
        ],
      ),

      //bottom navigation bar
      bottomNavigationBar: BottomNavigation(
        child: Padding(
          padding: Style.marginVertically / 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //remove button
                  Buttons.roundedIconBtn(
                    Icons.remove,
                    _detailsController.removeQuantity,
                    btnSize: 25,
                  ),

                  //quantity
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Obx(() => Text(
                          _detailsController.quantity.toString(),
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        )),
                  ),

                  //add buttion
                  Buttons.roundedIconBtn(
                    Icons.add,
                    _detailsController.addQuantity,
                    btnSize: 25,
                  ),
                  Spacer(),

                  //total price
                  Obx(
                    () => Text(
                      Values.tkSign +
                          _detailsController.totalPrice.toStringAsFixed(0),
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Spacer(),

                  Obx(
                    () {
                      bool isInCart = Get.find<AddToCartController>()
                          .isProductInCart(product);

                      return GestureDetector(
                        onTap: () => isInCart
                            ? Get.find<AddToCartController>()
                                .removeFromCart(product.id)
                            : Get.find<AddToCartController>()
                                .addToCart(product),
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
                              isInCart ? "Remove from cart" : "Add To Cart",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorPalette.textLight,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
