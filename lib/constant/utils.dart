import 'dart:math';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:prosiddho/model/cart_model/cart_model_product_details.dart';

class Util {
  static height(BuildContext context, {int percent = 100}) =>
      MediaQuery.of(context).size.height * (percent / 100);

  static width(BuildContext context, {int percent = 100}) =>
      MediaQuery.of(context).size.width * (percent / 100);

  static randomImage(images) => random(max: images.length - 1);

  static getUseableHeight(BuildContext context, {int percent = 100}) =>
      (MediaQuery.of(context).size.height -
          AppBar().preferredSize.height -
          MediaQuery.of(context).padding.top -
          MediaQuery.of(context).padding.bottom) *
      (percent / 100);

  static appBarHeight(BuildContext context) => AppBar().preferredSize.height;

  static int random({int min = 0, int max = 1}) =>
      min + Random().nextInt(max - min);

  static bool isPortrait(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.portrait ? true : false;

  static bool isLandscape(BuildContext context) => !isPortrait(context);

  static double heightOfSafeArea(BuildContext context) =>
      MediaQuery.of(context).padding.top;

  static bool isValid(dynamic data, {bool checkLength = true}) => data == null
      ? false
      : checkLength
          ? data.toString().length == 0
              ? false
              : true
          : false;

  static encode(String value) => base64Url.encode(
        utf8.encode(
          base64Url.encode(
            utf8.encode(value),
          ),
        ),
      );

  static decode(String value) => utf8.decode(
        base64Url.decode(
          utf8.decode(
            base64Url.decode(value),
          ),
        ),
      );

  static Duration timeDifference(Timestamp last) =>
      Timestamp.now().toDate().difference(last.toDate());

  static fullScreen({bool showTop = false, bool showBottom = false}) {
    if (showTop && showBottom) {
      return SystemChrome.setEnabledSystemUIOverlays(
          [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    } else if (showTop) {
      return SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    } else if (showBottom) {
      return SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);
    }

    return SystemChrome.setEnabledSystemUIOverlays([]);
  }

  static statusBarColor({
    Color color = Colors.amber,
  }) =>
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          statusBarColor: color,
        ),
      );

  static transparentStatusBar() => statusBarColor(color: Colors.transparent);

  static route(BuildContext context, dynamic page, {bool finish = false}) =>
      finish
          ? Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => page,
              ),
            )
          : Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => page,
              ),
            );

  static double horizontalTitlePadding(
      ScrollController _scrollController, double kExpandedHeight) {
    const kBasePadding = 50.0;

    if (_scrollController == null) return kBasePadding;

    if (_scrollController.hasClients) {
      if (_scrollController.offset < (kExpandedHeight / 3)) {
        // In case 50%-100% of the expanded height is viewed
        // return kBasePadding;

        return (kBasePadding / 2) + (_scrollController.offset * .41);
      }

      if (_scrollController.offset > (kExpandedHeight - kToolbarHeight)) {
        // In case 0% of the expanded height is viewed
        // return (kExpandedHeight / 2 - kToolbarHeight) * kMultiplier +
        //     kBasePadding;

        return kBasePadding;
      }

      return (kBasePadding / 2) + (_scrollController.offset * .41);

      // // In case 0%-50% of the expanded height is viewed
      // // return (_scrollController.offset - (kExpandedHeight / 2)) * kMultiplier +
      // //     kBasePadding;
    }

    return kBasePadding;
  }

  static double priceCalculate(CartModelProductDetails cartItem) {
    double perItemPrice = cartItem.productModel.price;

    //check offer and calculate price
    if (isValid(cartItem.productModel.priceOffer) &&
        cartItem.productModel.priceOffer != 0) {
      perItemPrice = cartItem.productModel.priceOffer;
    }

    //total price
    double totalPrice = perItemPrice * cartItem.cartModelProduct.quantity;

    //calcualte discount
    if (isValid(cartItem.productModel.priceOffer) &&
        cartItem.productModel.offerPercent != 0) {
      totalPrice -= totalPrice * (cartItem.productModel.offerPercent / 100);
    }

    return totalPrice;
  }
}
