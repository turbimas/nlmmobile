import 'package:flutter/material.dart';
import 'package:nlmmobile/product/models/category_model.dart';

class SearchResultViewModel extends ChangeNotifier {
  CategoryModel? categoryModel;
  String? searchText;
  List products = [];
  SearchResultViewModel(
      {required this.products, this.categoryModel, this.searchText});
}
