import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class Address {
  String addressLane;
  String city;
  int postalCode;
  String houseNo;
  String roadNo;
  String others;
  bool active;

  Address({
    @required this.addressLane,
    @required this.city,
    @required this.postalCode,
    @required this.houseNo,
    @required this.roadNo,
    @required this.others,
    @required this.active,
  });

  factory Address.fromFirestore(dynamic data) {
    return Address(
      addressLane: data[KeyWords.address_AddressLane],
      city: data[KeyWords.address_City],
      postalCode: data[KeyWords.address_PostalCode],
      houseNo: data[KeyWords.address_HouseNo],
      roadNo: data[KeyWords.address_RoadNo],
      others: data[KeyWords.address_Others],
      active: data[KeyWords.address_Active],
    );
  }

  static Map<String, dynamic> toMap({Address address}) {
    return {
      KeyWords.address_AddressLane: address == null ? '' : address.addressLane,
      KeyWords.address_City: address == null ? '' : address.city,
      KeyWords.address_PostalCode: address == null ? 0000 : address.postalCode,
      KeyWords.address_HouseNo: address == null ? '' : address.houseNo,
      KeyWords.address_RoadNo: address == null ? '' : address.roadNo,
      KeyWords.address_Others: address == null ? '' : address.others,
      KeyWords.address_Active: address == null ? false : address.active,
    };
  }
}
