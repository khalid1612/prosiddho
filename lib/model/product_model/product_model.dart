import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/product_model/birth_place.dart';

import 'buy_get.dart';
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
  int minimumOrder;
  int minimumOrderOffer;
  String name;
  BuyGet buyGet;
  double price;
  double priceOffer;
  int offerPercent;
  Rating rating;
  String shortDescription;
  String subtype;
  int totalComments;
  TotalSell totalSell;
  String type;
  String unit;
  List<String> videoLink = List();

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
    @required this.buyGet,
    @required this.price,
    @required this.priceOffer,
    @required this.offerPercent,
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

    //video link normalize
    int countVideoLink = data[KeyWords.productModel_videoLink].length ?? 0;
    List<String> tempVideoLink = List();

    if (countVideoLink > 0) {
      for (int i = 0; i < countVideoLink; i++) {
        tempVideoLink.add(data[KeyWords.productModel_videoLink][i]);
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
      buyGet: BuyGet.fromFirestore(data[KeyWords.productModel_buyGet]),
      price: double.parse(data[KeyWords.productModel_price].toString()),
      priceOffer:
          double.parse(data[KeyWords.productModel_priceOffer].toString()),
      offerPercent: data[KeyWords.productModel_offerPercent],
      rating: Rating.fromFirestore(data[KeyWords.productModel_rating]),
      shortDescription: data[KeyWords.productModel_shortDescription],
      subtype: data[KeyWords.productModel_subtype],
      totalComments: data[KeyWords.productModel_totalComments],
      totalSell: TotalSell.fromFirestore(data[KeyWords.productModel_totalSell]),
      type: data[KeyWords.productModel_type],
      unit: data[KeyWords.productModel_unit],
      videoLink: tempVideoLink,
    );
  }

  static Map<String, dynamic> toMap(ProductModel productModel) {
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
      KeyWords.productModel_offerPercent: productModel.offerPercent,
      KeyWords.productModel_name: productModel.name,
      KeyWords.productModel_buyGet: {
        KeyWords.buyGet_extra: productModel.buyGet.extra,
        KeyWords.buyGet_quantity: productModel.buyGet.quantity,
      },
      KeyWords.productModel_price: productModel.price,
      KeyWords.productModel_priceOffer: productModel.priceOffer,
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
