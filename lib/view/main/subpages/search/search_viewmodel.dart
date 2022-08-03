import 'package:flutter/material.dart';

class SearchViewModel extends ChangeNotifier {
  ScrollController categoriesScrollController;
  SearchViewModel({required this.categoriesScrollController}) {
    categoriesScrollController.addListener(() {
      if (categoriesScrollController.position.pixels < 40) {
        sizedBoxHeight = 40 - categoriesScrollController.position.pixels;
      } else {
        sizedBoxHeight = 0;
      }
    });
  }

  double _sizedBoxHeight = 0;
  double get sizedBoxHeight => _sizedBoxHeight;
  set sizedBoxHeight(double value) {
    _sizedBoxHeight = value;
    notifyListeners();
  }
}
