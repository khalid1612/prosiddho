import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/style/style_export.dart';
import 'package:prosiddho/views/category/category_screen.dart';
import 'package:get/get.dart';
import 'package:prosiddho/data/data.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/views/product_details/product_details_screen.dart';
import 'package:prosiddho/controller/wishlist_controller.dart';
import 'package:prosiddho/controller/add_to_cart_controller.dart';

class DivisionWithDistrict extends StatefulWidget {
  final int index;

  const DivisionWithDistrict({
    Key key,
    @required this.index,
  }) : super(key: key);

  @override
  _DivisionWithDistrictState createState() => _DivisionWithDistrictState();
}

class _DivisionWithDistrictState extends State<DivisionWithDistrict> {
  int selected = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFEFEFEF),
      appBar: AppBar(
        backgroundColor: ColorPalette.primary,
        title: Text(Data.division[widget.index].name),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            _districts(),
            Container(
              height: Get.height - 150,
              child: _items(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _districts() => Container(
        height: 50,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: Data.district(widget.index).length,
          itemBuilder: (context, dIndex) {
            String name = Data.district(widget.index)[dIndex];

            return GestureDetector(
              onTap: () {
                setState(() {
                  selected = dIndex;
                });
              },
              child: Center(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  margin: Style.marginHorizontalListview(
                      Data.district(widget.index).length, dIndex),
                  decoration: BoxDecoration(
                    color: selected == dIndex
                        ? ColorPalette.primaryPurple
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(
                      width: selected == dIndex ? 0 : 1,
                      color: ColorPalette.primaryPurple,
                    ),
                  ),
                  child: Text(
                    name,
                    style: TextStyle(
                      color:
                          selected == dIndex ? Colors.white : ColorPalette.text,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      );

  Widget _items() {
    ProductSearch productSearch = ProductSearch();
    List<ProductModel> products = productSearch.searchProductByDistrict(
      Data.division[widget.index].name,
      Data.district(widget.index)[selected],
    );

    int totalItem = products.length;

    return Padding(
      padding: Style.marginHorizontally,
      child: totalItem == 0
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    FontAwesomeIcons.sadCry,
                    color: Colors.grey,
                    size: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "No Item Found",
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            )
          : StaggeredGridView.countBuilder(
              crossAxisCount: 2,
              itemCount: totalItem,
              itemBuilder: (BuildContext context, int index) {
                return Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    _item(products[index]),
                  ],
                );
              },
              staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
              mainAxisSpacing: 30.0,
              crossAxisSpacing: 14.0,
            ),
    );
  }

  Widget _item(ProductModel product) => Container(
        height: 270,
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
                child: ImageLoading.cachedNetworkImage(product.imageLink[0],
                    radius: 20),
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
      );
}
