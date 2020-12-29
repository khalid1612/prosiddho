import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/product_details_screen_controller.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:carousel_pro/carousel_pro.dart';

import 'package:prosiddho/views/cart/cart_screen.dart';

class ProductDetailsScreen1 extends StatelessWidget {
  final ProductModel product;
  ProductDetailsScreen1({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _detailsController = Get.put(ProductDetailsScreenController());
    _detailsController.init(product);

    final double radius = 30.0;
    final iconSize = 40.0;

    List<Widget> item = List();

    for (String path in product.imageLink) {
      item.add(
        ImageLoading.cachedNetworkImage(path),
      );
    }

    return Scaffold(
      extendBodyBehindAppBar: true,
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
      body: Stack(
        children: [
          //image
          Container(
            height: Get.height * .67,
            color: Colors.grey,
            child: Carousel(
              autoplay: false,
              dotSize: 6.0,
              dotIncreasedColor: Color(0xFFFF335C),
              dotBgColor: Colors.transparent,
              indicatorBgPadding: 0.0,
              dotVerticalPadding: 80,
              images: item,
            ),
          ),

          //details
          DraggableScrollableSheet(
            initialChildSize: .4,
            maxChildSize: 0.7,
            minChildSize: 0.4,
            builder: (context, scrollController) {
              return Stack(
                children: [
                  //favorite icon
                  Positioned(
                    right: iconSize,
                    child: favoriteIcon(iconSize),
                  ),

                  //details
                  Container(
                    margin: EdgeInsets.only(top: iconSize * 1.4),
                    padding: Style.marginHorizontally,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(radius),
                        topRight: Radius.circular(radius),
                      ),
                    ),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      controller: scrollController,
                      children: [
                        //dragable icon
                        Center(
                          child: Container(
                            width: 70,
                            height: 5,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: ColorPalette.secondary,
                              borderRadius: Style.borderRadius,
                            ),
                          ),
                        ),

                        //product name
                        Text(
                          product.name,
                          style: Theme.of(context).textTheme.headline6,
                        ),

                        SizedBox(height: 3),

                        //division
                        Text.rich(
                          TextSpan(
                            text: product.birthPlace.division,
                            style: TextStyle(
                              fontSize: 14,
                            ),
                            children: [
                              TextSpan(text: " - "),
                              TextSpan(
                                text: product.birthPlace.districts.join(", "),
                                style: TextStyle(
                                  fontSize: 12,
                                  color: ColorPalette.text.withOpacity(.8),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 5),

                        //price
                        PriceStyle.priceStyle(
                          regular: product.price,
                          offer: product.priceOffer,
                        ),

                        SizedBox(height: 15),

                        //short description
                        Text(
                          Values.dummyDescription,
                          maxLines: 3,
                          style: TextStyle(
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),

      //bottom navigation bar
      bottomNavigationBar: BottomNavigation(
        child: Obx(
          () {
            bool isInCart =
                Get.find<AddToCartController>().isProductInCart(product);

            return GestureDetector(
              onTap: () => isInCart
                  ? Get.find<AddToCartController>().removeFromCart(product.id)
                  : Get.find<AddToCartController>().addToCart(product),
              child: Container(
                padding: Style.marginVertically / 1.5,
                decoration: BoxDecoration(
                  color: ColorPalette.primary,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Text(
                  isInCart ? "Remove from cart" : "Add To Cart",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: ColorPalette.textLight,
                    fontSize: 18,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget favoriteIcon(iconSize) {
    return Obx(() {
      bool isFavourite =
          Get.find<WishlistController>().wishlistIds.contains(product.id);

      return GestureDetector(
        behavior: HitTestBehavior.deferToChild,
        onTap: () {
          Get.find<WishlistController>().addToWishlist(product.id);
        },
        child: Container(
          width: Util.getProportionateScreenHeight(iconSize),
          height: Util.getProportionateScreenHeight(iconSize),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(
              isFavourite
                  ? FontAwesomeIcons.solidHeart
                  : FontAwesomeIcons.heart,
              color: isFavourite
                  ? ColorPalette.primaryRed
                  : ColorPalette.secondary,
              size: Util.getProportionateScreenHeight(20),
            ),
          ),
        ),
      );
    });
  }
}
