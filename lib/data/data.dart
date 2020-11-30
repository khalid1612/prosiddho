import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/assets.dart';
import 'package:prosiddho/constant/show_dialog.dart';
import 'package:prosiddho/enum/division.dart';
import 'package:prosiddho/model/category_model.dart';
import 'package:prosiddho/model/menu_model.dart';
import 'package:prosiddho/model/payment_model.dart';
import 'package:prosiddho/views/profile/profile_screen.dart';
import 'package:prosiddho/views/cart/cart_screen.dart';
import 'package:get/get.dart';
import 'package:prosiddho/controller/signin_controller.dart';
import 'package:prosiddho/enum/payment_getway.dart';

class Data {
  static List<CategoryModel> division = [
    //dhaka
    CategoryModel(
      name: Division.Dhaka.value,
      imagePath: Assets.dhaka,
      colorCode: 0XFFC0392B,
      districts: district(0),
    ),

    //chittagong
    CategoryModel(
      name: Division.Chittagong.value,
      imagePath: Assets.chittagong,
      colorCode: 0XFF17202A,
      districts: district(1),
    ),

    //khulna
    CategoryModel(
      name: Division.Khulna.value,
      imagePath: Assets.khulna,
      colorCode: 0XFF641E16,
      districts: district(2),
    ),

    //rangpur
    CategoryModel(
      name: Division.Rangpur.value,
      imagePath: Assets.rangpur,
      colorCode: 0XFF78281F,
      districts: district(3),
    ),

    //rajshahi
    CategoryModel(
      name: Division.Rajshahi.value,
      imagePath: Assets.rajshahi,
      colorCode: 0XFF17202A,
      districts: district(4),
    ),

    //barishal
    CategoryModel(
      name: Division.Barisal.value,
      imagePath: Assets.barishal,
      colorCode: 0XFF17202A,
      districts: district(5),
    ),

    //sylhet
    CategoryModel(
      name: Division.Sylhet.value,
      imagePath: Assets.sylhet,
      colorCode: 0XFF4A235A,
      districts: district(6),
    ),

    //maymensingh
    CategoryModel(
      name: Division.Mymensingh.value,
      imagePath: Assets.maymensingh,
      colorCode: 0XFF8E44AD,
      districts: district(7),
    ),
  ];

  static List<String> district(index) {
    List<List<String>> districtList = [
      //dhaka
      [
        "All",
        "Dhaka",
        "Faridpur",
        "Gazipur",
        "Gopalganj",
        "Kishoreganj",
        "Madaripur",
        "Manikganj",
        "Munshiganj",
        "Narayanganj",
        "Narsingdi",
        "Rajbari",
        "Shariatpur",
        "Tangail",
      ],

      //chittagong
      [
        "All",
        "Bandarban",
        "Brahmanbaria",
        "Chandpur",
        "Chittagong",
        "Comilla",
        "Cox's Bazar",
        "Feni",
        "Khagrachhari",
        "Lakshmipur",
        "Noakhali",
        "Rangamati",
      ],

      //khulna
      [
        "All",
        "Bagerhat",
        "Chuadanga",
        "Jessore",
        "Jhenaidah",
        "Khulna",
        "Kushtia",
        "Magura",
        "Meherpur",
        "Narail",
        "Satkhira",
      ],

      //rangpur
      [
        "All",
        "Dinajpur",
        "Gaibandha",
        "Kurigram",
        "Lalmonirhat",
        "Nilphamari",
        "Panchagarh",
        "Rangpur",
        "Thakurgaon",
      ],

      //rajshahi
      [
        "All",
        "Bogra",
        "Joypurhat",
        "Naogaon",
        "Natore",
        "Nawabganj",
        "Pabna",
        "Rajshahi",
        "Sirajganj",
      ],

      //barishal
      [
        "All",
        "Barguna",
        "Barishal",
        "Bhola",
        "Jhalokati",
        "Patuakhali",
        "Pirojpur",
      ],

      //sylhet
      [
        "All",
        "Habiganj",
        "Moulvibazar",
        "Sunamganj",
        "Sylhet",
      ],

      //maymensingh
      [
        "All",
        "Netrakona",
        "Mymensingh",
        "Jamalpur",
        "Sherpur",
      ],
    ];

    return districtList[index];
  }

  static List<MenuModel> menu = [
    MenuModel(
      name: 'Home',
      icon: EvaIcons.homeOutline,
      color: Colors.black,
      onTap: null,
    ),
    MenuModel(
      name: 'Profile',
      icon: EvaIcons.personOutline,
      color: Colors.black,
      onTap: () => ShowDialog.guestUserRestrictedFeature(ProfileScreen()),
    ),
    MenuModel(
      name: 'My Cart',
      icon: EvaIcons.shoppingCartOutline,
      color: Colors.black,
      onTap: () => Get.to(CartScreen()),
    ),
    MenuModel(
      name: 'Wishlist',
      icon: EvaIcons.heartOutline,
      color: Colors.black,
      onTap: null,
    ),
    MenuModel(
      name: 'My Orders',
      icon: EvaIcons.briefcaseOutline,
      color: Colors.black,
      onTap: null,
    ),
    MenuModel(
      name: 'Verify Product',
      icon: EvaIcons.checkmarkCircle2Outline,
      color: Colors.black,
      onTap: null,
    ),
    MenuModel(
      name: 'Settings',
      icon: EvaIcons.settingsOutline,
      color: Colors.black,
      onTap: null,
    ),
    MenuModel(
      name: 'CONTACT',
      icon: EvaIcons.emailOutline,
      color: Colors.black,
      onTap: null,
    ),
    MenuModel(
      name: 'SIGN OUT',
      icon: EvaIcons.logOutOutline,
      color: Colors.black,
      onTap: () => Get.find<SigninController>().signOutFromGoogle(),
    ),
  ];

  static List<PaymentModel> paymentOption = [
    PaymentModel(
      name: 'Cash on delivery',
      getway: PaymentGetway.cash_on_delivery.value,
      imagePath: Assets.cashOnDelivery,
      onTap: null,
    ),
    PaymentModel(
      name: 'Bkash',
      getway: PaymentGetway.bkash.value,
      imagePath: Assets.baksh,
      onTap: null,
    ),
    PaymentModel(
      name: 'Nogod',
      getway: PaymentGetway.nogod.value,
      imagePath: Assets.nogod,
      onTap: null,
    ),
    PaymentModel(
      name: 'Rocket',
      getway: PaymentGetway.rocket.value,
      imagePath: Assets.rocket,
      onTap: null,
    ),
    PaymentModel(
      name: 'Sure Cash',
      getway: PaymentGetway.sure_cash.value,
      imagePath: Assets.sureCash,
      onTap: null,
    ),
    PaymentModel(
      name: 'DBBL card / Nexus cart',
      getway: PaymentGetway.dbbl_card.value,
      imagePath: Assets.dbblCard,
      onTap: null,
    ),
    PaymentModel(
      name: 'Master card',
      getway: PaymentGetway.debit_credit_card.value,
      imagePath: Assets.masterCard,
      onTap: null,
    ),
  ];
}
