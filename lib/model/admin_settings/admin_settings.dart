import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';
import 'package:prosiddho/model/admin_settings/offer.dart';

class AdminSettings {
  bool serverMaintenance;
  String appVersion;
  int localDeliveryFee;
  int globalDeliveryFee;
  Offer offer;

  AdminSettings({
    @required this.serverMaintenance,
    @required this.appVersion,
    @required this.localDeliveryFee,
    @required this.globalDeliveryFee,
    @required this.offer,
  });

  factory AdminSettings.init() {
    return AdminSettings(
      serverMaintenance: null,
      appVersion: null,
      localDeliveryFee: null,
      globalDeliveryFee: null,
      offer: null,
    );
  }

  factory AdminSettings.fromFirestore(DocumentSnapshot data) {
    return AdminSettings(
      serverMaintenance: data[KeyWords.settingsModel_serverMaintenance],
      appVersion: data[KeyWords.settingsModel_appVersion],
      localDeliveryFee: data[KeyWords.settingsModel_localDeliveryFee],
      globalDeliveryFee: data[KeyWords.settingsModel_globalDeliveryFee],
      offer: Offer.formFirestore(data[KeyWords.settingsModel_offer]),
    );
  }
}
