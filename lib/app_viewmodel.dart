import 'package:flutter/material.dart';

class AppViewModel extends ChangeNotifier {
  AppViewModel();

  double _topPadding = 0;
  double get topPadding => _topPadding;
  set topPadding(double value) {
    _topPadding = value;
    notifyListeners();
  }
}
