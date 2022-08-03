import 'package:flutter/material.dart';

class CustomThemeData {
  CustomThemeData._();

  // basic colors

  static const List<Color> scaffoldBackgroundGradinetColors = [
    Color(0xFFFFFFFF),
    Color(0xFFDEFEE9)
  ];

  static const LinearGradient bannerCardGradient = LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: [
        Color.fromRGBO(14, 91, 40, 0.15),
        Color.fromRGBO(15, 130, 53, 0.15),
      ]);
  static const Color bannerChipColor = Color(0xffd9d9d9);

  static const Color searchBarBackgroundColor = Color(0xFF0F8235);
  static const Color searchBarTextColor = Color(0xFFFFFFFF);
  static const Color searchBarIconColor = Color(0xFFFFFFFF);

  static const Color bottomBarBackgroundColor = Color(0xFF0F8235);
  static const Color bottomBarHighlightColor = Color(0xFF0E5B28);
  static const Color bottomBarIconColor = Color(0xFFE9F3D0);
}
