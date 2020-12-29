import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/product_details/product_details_screen.dart';

class HomeHotProducts extends StatelessWidget {
  final List<ProductModel> products = ProductFilter.hotProducts();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
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

    return Padding(
      padding: Style.marginHorizontalListview(length, itemNo),
      child: GestureDetector(
        onTap: () {
          Get.to(ProductDetailsScreen(product: product));
        },
        child: SizedBox(
          width: Util.getProportionateScreenWidth(100),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 1.02,
                child: Container(
                  // padding: EdgeInsets.all(Util.getProportionateScreenHeight(5)),
                  decoration: BoxDecoration(
                    color: ColorPalette.bg.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: ImageLoading.cachedNetworkImage(url, radius: 15),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                "${product.name.capitalize}",
                style: TextStyle(
                  fontSize: 13,
                ),
              ),
              PriceStyle.priceStyle(
                regular: product.price,
                offer: product.priceOffer,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
