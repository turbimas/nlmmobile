import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
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
        PopupHelper.showError(message: responseModel.message);
      }
    } catch (e) {
      PopupHelper.showError(message: "${LocaleKeys.ErrorCodes_ERROR.tr()}\n$e");
    } finally {
      categoriesLoading = false;
    }
  }
}
