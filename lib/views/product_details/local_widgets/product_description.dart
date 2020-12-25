import 'package:flutter/material.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:get/get.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    @required this.product,
    this.pressOnSeeMore,
  }) : super(key: key);

  final ProductModel product;
  final GestureTapCallback pressOnSeeMore;

  @override
  Widget build(BuildContext context) {
    bool isFavourite =
        Get.find<WishlistController>().wishlistIds.contains(product.id);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Util.getProportionateScreenWidth(20)),
          child: Text(
            product.name,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Container(
            padding: EdgeInsets.all(Util.getProportionateScreenWidth(10)),
            width: Util.getProportionateScreenWidth(64),
            decoration: BoxDecoration(
              color: isFavourite ? Color(0xFFFFE6E6) : Color(0xFFF5F6F9),
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
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            left: Util.getProportionateScreenWidth(20),
            right: Util.getProportionateScreenWidth(64),
          ),
          child: Text(
            product.shortDescription,
            maxLines: 3,
          ),
        ),
      ],
    );
  }
}
