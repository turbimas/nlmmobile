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
      "cgDxpWsGsgJ70nNsz22Ay0mwa8PZICN27dagDv6r76TRPC3SlHrE1ZrLMkOqq-C0YwFV9elFpYVVM3jsW3mWTpajec2wS9ANsm9xaFV2KNlg6LPeDAExBZKImmYNNHeYTvDRb_uTT-XuRON4JaRoPfw6_B9tLCYxYyW551LcYsOK6AvMhPtRbBflM9WDSNdE0b0VGDOow9iBs75Se7eLrzWmtJBWgqTls1g024NBRiY";
}
