import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'local_widgets/custom_app_bar.dart';
import 'local_widgets/product_images.dart';
import 'local_widgets/top_rounded_container.dart';
import 'local_widgets/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: CustomAppBar(rating: product.rating.average),
      body: Column(
        children: [
          //produt images
          ProductImages(product: product),

          //details
          TopRoundedContainer(
            color: Colors.white,
            child: Column(
              children: [
                ProductDescription(
                  product: product,
                  pressOnSeeMore: () {},
                ),
              ],
            ),
          ),
        ],
      ),

      //bottom navigation bar
      bottomNavigationBar: BottomNavigation(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: [
                //add button
                Buttons.roundedIconBtn(
                  Icons.remove,
                  null,
                  size: 25,
                ),

                //quantity
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "${product.minimumOrder}",
                    style: TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ),

                //remove buttion
                Buttons.roundedIconBtn(
                  Icons.add,
                  null,
                  size: 25,
                ),

                Spacer(),

                //total price
                Text("\$1220"),
              ],
            ),
            RaisedButton(
              onPressed: () => null,
              child: Container(
                width: double.infinity,
                child: Center(child: Text("Add to cart")),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
