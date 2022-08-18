import 'package:flutter/material.dart';

abstract class NavigationService {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
  static BuildContext get context =>
      navigatorKey.currentState!.overlay!.context;

  static Future navigateToName(String route) async {
    await navigatorKey.currentState!.pushNamed(route);
  }

  static Future navigateToNameReplace(String route) async {
    await navigatorKey.currentState!.pushReplacementNamed(route);
  }

  static Future navigateToNameAndRemoveUntil(String route) async {
    await navigatorKey.currentState!
        .pushNamedAndRemoveUntil(route, (Route<dynamic> route) => false);
  }

  static Future navigateToPage(Widget page) async {
    await navigatorKey.currentState!
        .push(MaterialPageRoute(builder: (context) => page));
  }

  static Future navigateToPageReplace(Widget page) async {
    await navigatorKey.currentState!
        .pushReplacement(MaterialPageRoute(builder: (context) => page));
  }

  static Future navigateToPageAndRemoveUntil(Widget page) async {
    await navigatorKey.currentState!.pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => page),
        (Route<dynamic> route) => false);
  }

  static Future back() async {}
}
