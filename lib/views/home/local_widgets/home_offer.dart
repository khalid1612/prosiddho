import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:get/get.dart';
import 'package:prosiddho/constant/values.dart';
import 'package:prosiddho/controller/admin_controller.dart';
import 'package:prosiddho/controller/products_controller.dart';
import 'package:prosiddho/model/admin_settings/admin_settings.dart';
import 'package:prosiddho/style/style_export.dart';

class HomeOffer extends StatefulWidget {
  @override
  _HomeOfferState createState() => _HomeOfferState();
}

class _HomeOfferState extends State<HomeOffer> {
  final AdminSettings _offers = Get.find<AdminController>().adminSettings;

  List<Center> _offersWidget = List();
  List<Function> _offersFunction = List();

  @override
  void initState() {
    if (_offers.offer.dailyLoginOffer.point > 0) {
      _offersWidget.add(
        ImageLoading.cachedNetworkImage(
          _offers.offer.dailyLoginOffer.posterPath,
          radius: 12,
        ),
      );
      _offersFunction.add(null);
    }

    if (_offers.appVersion != Values.appVersion) {
      _offersWidget.add(
        ImageLoading.cachedNetworkImage(
          _offers.offer.appUpdateOffer.posterPath,
          radius: 12,
        ),
      );
      _offersFunction.add(() => print("Go to app update"));
    }

    if (_offers.offer.orderOffer.amountGte != null &&
        _offers.offer.orderOffer.amountGte > 0) {
      _offersWidget.add(
        ImageLoading.cachedNetworkImage(
          _offers.offer.orderOffer.posterPath,
          radius: 12,
        ),
      );
      _offersFunction.add(null);
    }

    if (Get.find<ProductController>().freeDeliveryAvailable()) {
      String url =
          'https://firebasestorage.googleapis.com/v0/b/prosiddho-7f1e5.appspot.com/o/offer_poster%2Ffd.png?alt=media&token=3ea68bd8-76b2-4cdd-b409-a5fdf12ffc9a';

      _offersWidget.add(
        ImageLoading.cachedNetworkImage(
          url,
          radius: 12,
        ),
      );
      _offersFunction.add(null);
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: Style.marginBase,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Carousel(
        boxFit: BoxFit.fill,
        borderRadius: true,
        radius: Radius.circular(12),
        animationCurve: Curves.fastOutSlowIn,
        animationDuration: Duration(milliseconds: 2000),
        autoplayDuration: Duration(milliseconds: 5000),
        dotSize: 6.0,
        dotIncreasedColor: Color(0xFFFF335C),
        dotBgColor: Colors.black.withOpacity(.1),
        showIndicator: false,
        indicatorBgPadding: 1.0,
        images: _offersWidget,
        onImageTap: (index) => _offersFunction[index] != null
            ? _offersFunction[index]()
            : print("no method found"),
      ),
    );
  }
}
