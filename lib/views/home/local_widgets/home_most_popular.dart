import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/product_details/product_details_screen.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';

class HomePopular extends StatelessWidget {
  final List<ProductModel> products = ProductFilter.mostPopular();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Util.getProportionateScreenHeight(20),
      ),
      child: Column(
        children: [
          ...List.generate(
            products.length - 1,
            (index) {
              return index % 2 == 0
                  ? _productItem(
                      products[index],
                      products[index + 1],
                      index,
                    )
                  : Container();
            },
          ),
        ],
      ),
    );
  }

  Widget _item(ProductModel product, bool first) {
    String url = Values.defaultImage;

    if (product.imageLink.length > 0) {
      url = product.imageLink[0];

      if (product.imageLink.length > 1) {
        url = product
            .imageLink[Util.random(min: 1, max: product.imageLink.length) - 1];
      }
    }

    return Expanded(
      child: Container(
        height: 270,
        margin: EdgeInsets.only(
          right: first ? 5 : 0,
          left: first ? 0 : 5,
          bottom: 30,
        ),
        decoration: BoxDecoration(
          color: ColorPalette.bg.withOpacity(.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //image
            GestureDetector(
              onTap: () {
                Get.to(ProductDetailsScreen(product: product));
              },
              child: SizedBox(
                height: 140,
                child: ImageLoading.cachedNetworkImage(url, radius: 20),
              ),
            ),

            //details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //name
                    GestureDetector(
                      onTap: () {
                        Get.to(ProductDetailsScreen(product: product));
                      },
                      child: Text(
                        "${product.name.capitalize}",
                        style: TextStyle(
                          color: ColorPalette.text,
                          fontSize: 16,
                        ),
                      ),
                    ),

                    //division
                    Text(
                      "${product.birthPlace.division}",
                      style: TextStyle(
                        color: ColorPalette.text.withOpacity(.5),
                        fontSize: 12,
                      ),
                    ),

                    SizedBox(height: 5),

                    //price
                    PriceStyle.priceStyle(
                      regular: product.price,
                      offer: product.priceOffer,
                    ),

                    Spacer(),
                    //add to cart
                    //add to favorite
                    //rating
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        //rating icon
                        Icon(
                          FontAwesomeIcons.solidStar,
                          size: Util.getProportionateScreenHeight(10),
                          color: ColorPalette.primaryPurple,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        //rating
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: product.rating.average != null
                                      ? product.rating.average
                                          .toStringAsFixed(1)
                                      : "0"),
                            ],
                          ),
                        ),

                        Spacer(),

                        //add to favorite
                        Obx(() {
                          bool isFavourite = Get.find<WishlistController>()
                              .wishlistIds
                              .contains(product.id);

                          return GestureDetector(
                            onTap: () {
                              Get.find<WishlistController>()
                                  .addToWishlist(product.id);
                            },
                            child: Container(
                              width: Util.getProportionateScreenHeight(28),
                              height: Util.getProportionateScreenHeight(28),
                              decoration: BoxDecoration(
                                color: isFavourite
                                    ? ColorPalette.primaryRed.withOpacity(.1)
                                    : ColorPalette.bg.withOpacity(.2),
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
                                  size: Util.getProportionateScreenHeight(15),
                                ),
                              ),
                            ),
                          );
                        }),

                        //add to cart
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
                                width: Util.getProportionateScreenHeight(28),
                                height: Util.getProportionateScreenHeight(28),
                                margin: EdgeInsets.only(left: 7),
                                decoration: BoxDecoration(
                                  color: ColorPalette.bg.withOpacity(.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  isInCart
                                      ? FontAwesomeIcons.trash
                                      : FontAwesomeIcons.plus,
                                  size: Util.getProportionateScreenHeight(15),
                                  color: isInCart
                                      ? ColorPalette.primaryRed
                                      : ColorPalette.primaryPurple,
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
          ],
        ),
      ),
    );
  }

  Widget _productItem(
    ProductModel product1,
    ProductModel product2,
    int itemNo,
  ) {
    return Row(
      children: [
        _item(product1, true),
        _item(product2, false),
      ],
    );
  }
}
