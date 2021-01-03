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

        //minimum order
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Util.getProportionateScreenWidth(20),
            vertical: Util.getProportionateScreenWidth(5),
          ),
          child: Text(
            "Minimum Order ${product.priceOffer == 0 ? product.minimumOrder : product.minimumOrderOffer}  ${product.unit}",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ),

        //discount buy get
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Util.getProportionateScreenWidth(20),
            vertical: Util.getProportionateScreenWidth(5),
          ),
          child: Row(
            children: [
              //offerPercent
              if (product.offerPercent != null && product.offerPercent != 0)
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
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Discount: ${product.offerPercent}%",
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                ),

              //buy get
              if (product.buyGet.quantity != null)
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 2.0,
                  ),
                  margin: EdgeInsets.symmetric(
                    vertical: 5,
                  ).copyWith(right: 10),
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "Buy: ${product.buyGet.quantity}  Get: ${product.buyGet.extra}",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
            ],
          ),
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
