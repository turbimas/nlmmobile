// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

class AppConstants {
  static const double designHeight = 800;
  static const double designWidth = 360;
  static Size get designSize => const Size(designWidth, designHeight);

  static const TR_LOCALE = Locale("tr");
  static const AR_LOCALE = Locale("ar");
  static const EN_LOCALE = Locale("en");
  static const PATH_LOCALE = "assets/lang";

  static const IOS_Version = "1.0.0";
  static const ANDROID_Version = "1.0.0";

  static const APP_API = "http://www.api.goldenerp.com/api/";

  static const APP_TOKEN =
      "8pS13Hxe6ZCTU1wVue-PHhDqA4m0vl4JokWb1FTMxiGoGBGmow6Q5VJmT7W9ODmhcXuC-erH0qV9QjxseYwT7Rha096kJ7_gAgJ2sjLxSFvFCZ_-Vtu9QZq6nqztV72oJTef71aYACOb3AXrcgZDDPiPt8NxR1T5eT7n2oMFK7FLj2HSdrEys_0sLd0NfIWwEBrW6P06RodMSQTH-VBYfyNylr8JppGJrXe_6bT-NZw";
}
