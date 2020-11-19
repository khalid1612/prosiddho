import 'package:flutter/material.dart';
import 'package:prosiddho/constant/keywords.dart';

class Gmail {
  //all field value provide by google auth service
  String uid;
  String email;
  String displayName;
  String photoURL;
  String phoneNumber;

  Gmail({
    @required this.uid,
    @required this.email,
    @required this.displayName,
    @required this.photoURL,
    @required this.phoneNumber,
  });

  factory Gmail.fromFirestore(dynamic data) {
    return Gmail(
      uid: data[KeyWords.gmail_Uid],
      email: data[KeyWords.gmail_Email],
      displayName: data[KeyWords.gamil_DisplayName],
      photoURL: data[KeyWords.gmail_PhotoURL],
      phoneNumber: data[KeyWords.gmail_PhoneNumber],
    );
  }

  static Map<String, dynamic> toMap(Gmail gmail) {
    return {
      KeyWords.gmail_Uid: gmail.uid,
      KeyWords.gmail_Email: gmail.email,
      KeyWords.gamil_DisplayName: gmail.displayName,
      KeyWords.gmail_PhotoURL: gmail.photoURL,
      KeyWords.gmail_PhoneNumber: gmail.phoneNumber,
    };
  }
}
