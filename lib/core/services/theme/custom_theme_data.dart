import 'package:flutter/material.dart';

class CustomThemeData {
  static final paymentDetailGradient = LinearGradient(
    end: Alignment.topCenter,
    begin: Alignment.bottomCenter,
    colors: [
      const Color.fromRGBO(202, 255, 233, 1),
      Colors.white.withOpacity(0.75)
    ],
  );

  // basics
  static const Color primaryColor = Color(0XFF0E5B28);
  static const Color secondaryColor = Color(0XFF0F8235);

  // widgets
  static const Color safeAreaColor = primaryColor;
  static const Color appBarColor = primaryColor;
  static const List<Color> scaffoldBackgroundGradientColors = [
    Colors.white,
    Color.fromRGBO(222, 254, 233, 1),
    Colors.yellow
  ];

  // custom widgets

  static const List<Color> bannerCardGradientColors = [
    Color.fromRGBO(14, 91, 40, 0.15),
    Color.fromRGBO(15, 130, 53, 0.15),
  ];
  static const Color bannerChipColor = Color(0xffd9d9d9);

  static const Color searchBarBackgroundColor = Color(0xFF0F8235);
  static const Color searchBarTextColor = Color(0xFFFFFFFF);
  static const Color searchBarIconColor = Color(0xFFFFFFFF);

  static const Color bottomBarBackgroundColor = Color(0xFF0F8235);
  static const Color bottomBarHighlightColor = Color(0xFF0E5B28);
  static const Color bottomBarIconColor = Color(0xFFE9F3D0);

  static const Color profileCardColor = Color(0xffB5D7C0);
}
