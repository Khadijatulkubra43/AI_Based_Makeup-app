import 'package:flutter/material.dart';

Color mBackgroundColor = const Color(0xFFFFFFFF);

Color mCardBackgroundColor = const Color(0xFFecebe7);

Color mDarkBackgroundColor = const Color(0xFF343434);

Color mPrimaryColor = const Color(0xFFE8D1B2);

const popularCosmeticsList = [
  {
    'name': 'Make up for ever',
    'star': 5.0,
    'imageUrl': 'assets/images/product1.png'
  },
  {
    'name': 'Insta Moisture',
    'star': 5.0,
    'imageUrl': 'assets/images/product2.png'
  }
];

const cosmeticsFullList = [
  'assets/images/product_full1.png',
  'assets/images/product_full2.png'
];

class Constants {
  //Primary color
  static var primaryColor = const Color.fromARGB(255, 177, 69, 163);
  static var blackColor = const Color.fromARGB(137, 235, 229, 229);

  //Onboarding texts
  static var titleOne = "Make makeup or inhance your beauty";
  static var descriptionOne =
      "Read how to make perfect makeup for different occasions";
  static var titleTwo = "Enhance Your Look ";
  static var descriptionTwo =
      "Discover the best makeup tips and techniques for every occasion.";
  static var titleThree = "Flawless Beauty";
  static var descriptionThree =
      "Learn how to achieve a flawless look with expert makeup advice.";
}
