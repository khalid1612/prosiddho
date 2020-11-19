import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class AccountStatus {
  String status;
  String reason;

  AccountStatus({
    @required this.status,
    @required this.reason,
  });

  factory AccountStatus.fromFirestore(dynamic data) {
    return AccountStatus(
      status: data[KeyWords.accountStatus_Status],
      reason: data[KeyWords.accountStatus_Reason],
    );
  }

  static Map<String, dynamic> toMap(AccountStatus accountStatus) {
    return {
      KeyWords.accountStatus_Status: accountStatus.status,
      KeyWords.accountStatus_Reason: accountStatus.reason,
    };
  }
}
