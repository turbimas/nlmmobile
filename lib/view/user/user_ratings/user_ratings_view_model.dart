import 'package:flutter/material.dart';

class UserRatingsViewModel extends ChangeNotifier {
  // List<RatingModel> rated = List.generate(10, (index) => RatingModel.test());

  int _index = 0;
  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;
      notifyListeners();
    }
  }

  UserRatingsViewModel();
}
