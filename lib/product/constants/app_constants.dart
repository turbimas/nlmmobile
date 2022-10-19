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

  static const APP_API = "http://www.koyevi.publicvm.com:88/api/";

  static const APP_TOKEN =
      "rG9IqCqNH5vWXPZ3-IwjgQv4k2oOPlijnCJIsWk0UdoaQT-muXWB1v0eVVz9Zqq9dhxpKOgRVh5p7Vi7xcUc_mBFdyuxjBKszZJ_AxYd5wKXOZkz_pnvQDGP5V1hQP6LHgUSEq2hXz0bd8X5ezph0fPIYwGH6XAqD18ScqnDcQ4uUBooRgPA-fLpVjTCcI_VJQIlSmVcVNVV3mLttgTtWAgaKSfb8fN8tLhfqklLvKI";
}
