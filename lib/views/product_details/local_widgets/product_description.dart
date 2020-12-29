import 'package:flutter/material.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:get/get.dart';
import 'package:prosiddho/style/style_export.dart';

class ProductDescription extends StatelessWidget {
  final ProductModel product;

  ProductDescription({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //product name
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Util.getProportionateScreenWidth(20),
          ),
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),

        //division
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Util.getProportionateScreenWidth(20),
          ),
          child: Text.rich(
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
        ),

        //favorite icon
        Row(
          children: [
            //price
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Util.getProportionateScreenWidth(20),
              ),
              child: PriceStyle.priceStyle(
                regular: product.price,
                offer: product.priceOffer,
                fontSize: 20,
                fontColor: ColorPalette.primaryPurple,
              ),
            ),

            Spacer(),

            //add to favorite
            GestureDetector(
              onTap: () {
                Get.find<WishlistController>().addToWishlist(product.id);
              },
              child: Align(
                alignment: Alignment.centerRight,
                child: Obx(() {
                  bool isFavourite = Get.find<WishlistController>()
                      .wishlistIds
                      .contains(product.id);

                  return Container(
                    padding:
                        EdgeInsets.all(Util.getProportionateScreenWidth(10)),
                    width: Util.getProportionateScreenWidth(64),
                    decoration: BoxDecoration(
                      color:
                          isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                    ),
                    child: Icon(
                      isFavourite ? Icons.favorite : Icons.favorite_border,
                      color: isFavourite ? Color(0xFFFF4848) : Colors.green,
                      size: Util.getProportionateScreenWidth(20),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),

        //short description
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Util.getProportionateScreenWidth(20),
            vertical: Util.getProportionateScreenWidth(5),
          ),
          child: Text(
            Values.dummyDescription,
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
