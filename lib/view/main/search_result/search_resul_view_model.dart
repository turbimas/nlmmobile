import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nlmmobile/product/models/category_model.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';

class SearchResultViewModel extends ChangeNotifier {
  CategoryModel? categoryModel;
  String? searchText;
  List<ProductOverViewModel> products = [];
  SearchResultViewModel(
      {required this.products, this.categoryModel, this.searchText}) {
    log("SearchResultViewModel");
  }
}
