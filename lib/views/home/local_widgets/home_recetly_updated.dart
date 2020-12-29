import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/product_details/product_details_screen.dart';

class HomeRecentlyUpdated extends StatelessWidget {
  final List<ProductModel> products = ProductFilter.recentlyUpdated();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ...List.generate(
            products.length,
            (index) => _productItem(
              products[index],
              products.length,
              index,
            ),
          ),
        ],
      ),
    );
  }

  Widget _productItem(ProductModel product, int length, int itemNo) {
    String url = Values.defaultImage;

    if (product.imageLink.length > 0) {
      url = product.imageLink[0];

      if (product.imageLink.length > 1) {
        url = product
            .imageLink[Util.random(min: 1, max: product.imageLink.length) - 1];
      }
    }

    return GestureDetector(
      onTap: () {
        Get.to(ProductDetailsScreen(product: product));
      },
      child: Container(
        height: Util.getProportionateScreenHeight(90),
        width: Util.getProportionateScreenWidth(242),
        margin: Style.marginHorizontalListview(length, itemNo),
        decoration: BoxDecoration(
          color: ColorPalette.bg.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            //image
            SizedBox(
              width: Util.getProportionateScreenWidth(242) * .35,
              child: ImageLoading.cachedNetworkImage(url, radius: 20),
            ),

            //details
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 10.0,
                  left: 10.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //product name
                    Text(
                      "${product.name.capitalize}",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),

                    //divisition
                    Text("${product.birthPlace.division}"),

                    SizedBox(height: 5),

                    //price
                    PriceStyle.priceStyle(
                      regular: product.price,
                      offer: product.priceOffer,
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
}
