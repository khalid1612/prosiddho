import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/style/style_export.dart';

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

    return Container(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
