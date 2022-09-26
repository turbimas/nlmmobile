import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/category_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _categoriesLoading = true;
  bool get categoriesLoading => _categoriesLoading;
  set categoriesLoading(bool value) {
    _categoriesLoading = value;
    notifyListeners();
  }

  List<CategoryModel> categories = [];
  HomeViewModel();

  Future<void> getCategories() async {
    try {
      categoriesLoading = true;
      ResponseModelList responseModel =
          await NetworkService.get<List>("api/categories/getcategories/0");
      if (responseModel.success) {
        categories =
            (responseModel.data).map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        PopupHelper.showErrorDialog(errorMessage: responseModel.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorDialogWithCode(e);
    } finally {
      categoriesLoading = false;
    }
  }
}
