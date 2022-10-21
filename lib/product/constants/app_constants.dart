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
      "9MzVNwaodK-C0z1nizPmQBtsfqs83ZK9jccOlz1PtLM9vcflVTxefE895xkPkBV-F9HTTIwLmGizOzfAMsR_t7f3I0O1s6Y2yoixbNbenbB1oyrJiWJOVDFbm51OrO8eLKju7d0ZL6QnsaaX6YvQFjGcSnCffxqS2S50ek1e7pSh5hPE0kRPVWvS7iZnABYKX5NjE5PLRFlfCd9Sv2VmRQHKPl_OfIJKEe4I_2zAXBc";
}
