import 'package:flutter/material.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/product_details_screen_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';

import 'local_widgets/custom_app_bar.dart';
import 'local_widgets/product_images.dart';
import 'local_widgets/top_rounded_container.dart';
import 'local_widgets/product_description.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;
  ProductDetailsScreen({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _detailsController = Get.put(ProductDetailsScreenController());
    _detailsController.init(product);

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
                ProductDescription(product: product),
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
                //remove button
                Buttons.roundedIconBtn(
                  Icons.remove,
                  _detailsController.removeQuantity,
                  size: 25,
                ),

                //quantity
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Obx(() => Text(
                        _detailsController.quantity.toString(),
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                      )),
                ),

                //add buttion
                Buttons.roundedIconBtn(
                  Icons.add,
                  _detailsController.addQuantity,
                  size: 25,
                ),

                Spacer(),

                //total price
                Obx(
                  () => Text(
                    _detailsController.totalPrice.toStringAsFixed(2),
                  ),
                ),
              ],
            ),
            RaisedButton(
              onPressed: () =>
                  Get.find<AddToCartController>().addToCart(product),
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
