import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/admin_settings/offer.dart';

class AdminSettings {
  bool serverMaintenance;
  int localDeliveryFee;
  int globalDeliveryFee;
  int newUserPoint;
  Offer offer;

  AdminSettings({
    @required this.serverMaintenance,
    @required this.localDeliveryFee,
    @required this.globalDeliveryFee,
    @required this.newUserPoint,
    @required this.offer,
  });

  factory AdminSettings.fromFirestore(DocumentSnapshot data) {
    return AdminSettings(
      serverMaintenance: data[KeyWords.settingsModel_serverMaintenance],
      localDeliveryFee: data[KeyWords.settingsModel_localDeliveryFee],
      globalDeliveryFee: data[KeyWords.settingsModel_globalDeliveryFee],
      newUserPoint: data[KeyWords.settingsModel_newUserPoint],
      offer: Offer.formFirestore(data[KeyWords.settingsModel_offer]),
    );
  }
}
