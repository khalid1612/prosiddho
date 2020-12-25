import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/product_details/product_details_screen.dart';

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
      child: GestureDetector(
        onTap: () {
          Get.to(ProductDetailsScreen(product: product));
        },
        child: Container(
          height: 260,
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
              SizedBox(
                height: 140,
                child: ImageLoading.cachedNetworkImage(url, radius: 20),
              ),

              //details
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "${product.name.capitalize}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "${product.birthPlace.division}",
                      ),
                      Text(
                        "${product.price}",
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
                            FontAwesomeIcons.starHalfAlt,
                            size: Util.getProportionateScreenHeight(10),
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
                                TextSpan(text: "/"),
                                TextSpan(text: "5"),
                              ],
                            ),
                          ),

                          Spacer(),

                          //add to favorite
                          Container(
                            width: Util.getProportionateScreenHeight(28),
                            height: Util.getProportionateScreenHeight(28),
                            decoration: BoxDecoration(
                              color: ColorPalette.bg.withOpacity(.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              FontAwesomeIcons.heart,
                              size: Util.getProportionateScreenHeight(15),
                            ),
                          ),

                          //add to cart
                          Container(
                            width: Util.getProportionateScreenHeight(28),
                            height: Util.getProportionateScreenHeight(28),
                            margin: EdgeInsets.only(left: 7),
                            decoration: BoxDecoration(
                              color: ColorPalette.bg.withOpacity(.2),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              FontAwesomeIcons.plus,
                              size: Util.getProportionateScreenHeight(15),
                            ),
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
