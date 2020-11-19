import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/product_model/birth_place.dart';

import 'buy_get.dart';
import 'price.dart';
import 'rating.dart';
import 'total_sell.dart';

class ProductModel {
  String id;
  bool available;
  int stock;
  BirthPlace birthPlace;
  Timestamp createDate;
  String fullDescription;
  List<String> imageLink = List();
  Timestamp lastUpdateDate;
  double minimumOrder;
  double minimumOrderOffer;
  String name;
  bool offer;
  BuyGet buyGet;
  Price price;
  List<Price> priceOffer = List();
  Rating rating;
  String shortDescription;
  String subtype;
  int totalComments;
  TotalSell totalSell;
  String type;
  String unit;
  String videoLink;

  ProductModel({
    @required this.id,
    @required this.available,
    @required this.stock,
    @required this.birthPlace,
    @required this.createDate,
    @required this.fullDescription,
    @required this.imageLink,
    @required this.lastUpdateDate,
    @required this.minimumOrder,
    @required this.minimumOrderOffer,
    @required this.name,
    @required this.offer,
    @required this.buyGet,
    @required this.price,
    @required this.priceOffer,
    @required this.rating,
    @required this.shortDescription,
    @required this.subtype,
    @required this.totalComments,
    @required this.totalSell,
    @required this.type,
    @required this.unit,
    @required this.videoLink,
  });

  @override
  String toString() {
    return '{ ${this.totalComments}';
  }

  factory ProductModel.fromFirestore({
    DocumentSnapshot documentSnapshot,
    QueryDocumentSnapshot queryDocumentSnapshot,
    String productId,
  }) {
    var data = documentSnapshot ?? queryDocumentSnapshot;

    //image link normalize
    int countImageLink = data[KeyWords.productModel_imageLink].length ?? 0;
    List<String> tempImageLink = List();

    if (countImageLink > 0) {
      for (int i = 0; i < countImageLink; i++) {
        tempImageLink.add(data[KeyWords.productModel_imageLink][i]);
      }
    }

    //price offer normalize
    int countPriceOffer = data[KeyWords.productModel_priceOffer].length ?? 0;
    List<Price> tempPriceOffer = List();

    if (countPriceOffer > 0) {
      for (int i = 0; i < countPriceOffer; i++) {
        tempPriceOffer.add(
          Price.fromFirstore(data[KeyWords.productModel_priceOffer][i]),
        );
      }
    }

    return ProductModel(
      id: productId ?? data.id,
      available: data[KeyWords.productModel_available],
      stock: data[KeyWords.productModel_stock],
      birthPlace:
          BirthPlace.fromFirestore(data[KeyWords.productModel_birthPlace]),
      createDate: data[KeyWords.productModel_createDate],
      fullDescription: data[KeyWords.productModel_fullDescription],
      imageLink: tempImageLink,
      lastUpdateDate: data[KeyWords.productModel_lastUpdateDate],
      minimumOrder: data[KeyWords.productModel_minimumOrder],
      minimumOrderOffer: data[KeyWords.productModel_minimumOrderOffer],
      name: data[KeyWords.productModel_name],
      offer: data[KeyWords.productModel_offer],
      buyGet: BuyGet.fromFirestore(data[KeyWords.productModel_buyGet]),
      price: Price.fromFirstore(data[KeyWords.productModel_price]),
      priceOffer: tempPriceOffer,
      rating: Rating.fromFirestore(data[KeyWords.productModel_rating]),
      shortDescription: data[KeyWords.productModel_shortDescription],
      subtype: data[KeyWords.productModel_subtype],
      totalComments: data[KeyWords.productModel_totalComments],
      totalSell: TotalSell.fromFirestore(data[KeyWords.productModel_totalSell]),
      type: data[KeyWords.productModel_type],
      unit: data[KeyWords.productModel_unit],
      videoLink: data[KeyWords.productModel_videoLink],
    );
  }

  static Map<String, dynamic> toMap(ProductModel productModel) {
    List<dynamic> priceList = [];
    if (productModel.priceOffer.length > 0) {
      for (Price price in productModel.priceOffer) {
        priceList.add({
          KeyWords.price_price: price.price,
          KeyWords.price_quantity: price.quantity,
        });
      }
    }

    return {
      KeyWords.productModel_available: productModel.available,
      KeyWords.productModel_stock: productModel.stock,
      KeyWords.productModel_birthPlace: {
        KeyWords.birthPlace_division: productModel.birthPlace.division,
        KeyWords.birthPlace_district: productModel.birthPlace.districts,
      },
      KeyWords.productModel_createDate: productModel.createDate,
      KeyWords.productModel_fullDescription: productModel.fullDescription,
      KeyWords.productModel_imageLink: productModel.imageLink,
      KeyWords.productModel_lastUpdateDate: productModel.lastUpdateDate,
      KeyWords.productModel_minimumOrder: productModel.minimumOrder,
      KeyWords.productModel_minimumOrderOffer: productModel.minimumOrderOffer,
      KeyWords.productModel_name: productModel.name,
      KeyWords.productModel_offer: productModel.offer,
      KeyWords.productModel_buyGet: {
        KeyWords.buyGet_extra: productModel.buyGet.extra,
        KeyWords.buyGet_quantity: productModel.buyGet.quantity,
      },
      KeyWords.productModel_price: {
        KeyWords.price_price: productModel.price.price,
        KeyWords.price_quantity: productModel.price.quantity,
      },
      KeyWords.productModel_priceOffer: priceList,
      KeyWords.productModel_rating: {
        KeyWords.rating_average: productModel.rating.average,
        KeyWords.rating_userCount: productModel.rating.userCount,
      },
      KeyWords.productModel_shortDescription: productModel.shortDescription,
      KeyWords.productModel_subtype: productModel.subtype,
      KeyWords.productModel_totalComments: productModel.totalComments,
      KeyWords.productModel_totalSell: {
        KeyWords.totalSell_TotalOrder: productModel.totalSell.totalOrder,
        KeyWords.totalSell_TotalUnitSell: productModel.totalSell.totalUnitSell,
      },
      KeyWords.productModel_type: productModel.type,
      KeyWords.productModel_unit: productModel.unit,
      KeyWords.productModel_videoLink: productModel.videoLink,
    };
  }
}
