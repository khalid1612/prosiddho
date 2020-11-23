import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:prosiddho/constant/assets.dart';
import 'package:prosiddho/constant/show_dialog.dart';
import 'package:prosiddho/enum/division.dart';
import 'package:prosiddho/model/category_model.dart';
import 'package:prosiddho/model/menu_model.dart';
import 'package:prosiddho/views/profile/profile_screen.dart';

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
      onTap: null,
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
      onTap: null,
    ),
  ];
}
