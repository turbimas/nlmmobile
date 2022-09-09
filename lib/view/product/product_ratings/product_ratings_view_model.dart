import 'package:flutter/material.dart';

class ProductRatingsViewModel extends ChangeNotifier {
  ProductRatingsViewModel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
