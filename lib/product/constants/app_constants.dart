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

  static const APP_API = "http://api.goldenerp.com/api/";

  static const APP_TOKEN =
      "tRexzvlEFNl3sNgVdTjQ-C8xu0rB-GS2ZBqol8Kh9ECNLMgdEav_89p_HR1NOFWcmg_1uL09sWrJcVu2lFRJrwKZAzXTxkllVXuv2nDwYAvUTzaNOSAlz5O0zNxJlAKJm_NS9Nl2M4Tj5OxUiAktkQH3V0pbddL3u1-3pgz-9qdLZW9CMEROYOPj7WWde3ppYCCX8LfcTo19xihmBHOa-8s8RO5JTVnA5F7uNOkkQ7U";
}
