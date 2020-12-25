import 'package:flutter/material.dart';
import 'package:prosiddho/model/product_model/product_model.dart';
import 'package:prosiddho/constant/constant_export.dart';
import 'package:prosiddho/style/style_export.dart';

class ProductImages extends StatefulWidget {
  final ProductModel product;

  const ProductImages({
    Key key,
    @required this.product,
  }) : super(key: key);

  @override
  _ProductImagesState createState() => _ProductImagesState();
}

class _ProductImagesState extends State<ProductImages> {
  int selectedImage = 0;

  @override
  Widget build(BuildContext context) {
    int showMoreCount = 0;

    //count extra video
    if (widget.product.videoLink.length > 1) {
      showMoreCount += widget.product.videoLink.length - 1;
    }

    //count extra image
    if (widget.product.imageLink.length > 2) {
      showMoreCount +=
          widget.product.imageLink.length - showMoreCount == 0 ? 3 : 2;
    }

    return Column(
      children: [
        Container(
          margin: Style.marginBase,
          height: Util.getProportionateScreenHeight(180),
          child: Hero(
            tag: widget.product.id.toString(),
            child: ImageLoading.cachedNetworkImage(
              widget.product.imageLink[selectedImage],
              radius: 10,
            ),
          ),
        ),
        // SizedBox(height: getProportionateScreenWidth(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //play pause icon for video
            if (widget.product.videoLink != null &&
                widget.product.videoLink.length > 0)
              buildPlayPauseButton(),

            //show images
            ...List.generate(
                widget.product.imageLink.length > 3
                    ? 3
                    : widget.product.imageLink.length,
                (index) => buildSmallProductPreview(index)),

            //if image is more than 3 show plus icon
            if (widget.product.imageLink.length > 3 ||
                widget.product.videoLink.length > 1)
              buildMoreButton(showMoreCount),
          ],
        )
      ],
    );
  }

  Widget buildPlayPauseButton() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(5),
        height: Util.getProportionateScreenWidth(48),
        width: Util.getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(Icons.play_arrow),
      ),
    );
  }

  GestureDetector buildSmallProductPreview(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedImage = index;
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 250),
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(5),
        height: Util.getProportionateScreenWidth(48),
        width: Util.getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
              color: Color(0xFFFF7643)
                  .withOpacity(selectedImage == index ? 1 : 0)),
        ),
        child: ImageLoading.cachedNetworkImage(
          widget.product.imageLink[index],
          radius: 10,
        ),
      ),
    );
  }

  Widget buildMoreButton(int count) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        margin: EdgeInsets.only(right: 15),
        padding: EdgeInsets.all(5),
        height: Util.getProportionateScreenWidth(48),
        width: Util.getProportionateScreenWidth(48),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            "+$count",
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
        ),
      ),
    );
  }
}
