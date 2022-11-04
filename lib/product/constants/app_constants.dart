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

  static String APP_TOKEN =
      "C6c0N8ReUHJO4XUxZH_BABC1XT9kaAWfVwaor6SJBWx_pyv-C_aXaa_9Myhdk9MZ2qH6riA-Wa2f6TcDxtjLt2fxaElybc_k5MNvfcz2G-RIychSG7UbNcnMJnUw6iEI2UvUqhMswmxsUuQYNcuklR-yBJzJyfLba8oNAx8GbWUabYEPKpwycFWSopI3NyJ7tWhgSZAqoTm6aYb-BZ4Zhyc4M3OjWcFFPSaZ1FRubNI";
}
