import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseHelper {
  static CollectionReference collectionProductDetails =
      FirebaseFirestore.instance.collection("productDetails");

  static CollectionReference collectionCart =
      FirebaseFirestore.instance.collection("cart");

  static CollectionReference collectionUsers =
      FirebaseFirestore.instance.collection("users");

  static CollectionReference collectionOrder =
      FirebaseFirestore.instance.collection("order");

  static CollectionReference collectionCoupon =
      FirebaseFirestore.instance.collection("coupon");

  static CollectionReference collectionCouponUsedHistory =
      FirebaseFirestore.instance.collection("couponUsedHistory");

  static CollectionReference collectionSettings =
      FirebaseFirestore.instance.collection("settings");

  static CollectionReference collectionPayment =
      FirebaseFirestore.instance.collection("payment");

  static CollectionReference collectionWishlist =
      FirebaseFirestore.instance.collection("wishlist");
}
