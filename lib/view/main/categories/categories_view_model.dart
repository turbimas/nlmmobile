import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/category_model.dart';

class CategoriesViewModel extends ChangeNotifier {
  CategoriesViewModel();

  Future<List<CategoryModel>?> getCategories() async {
    try {
      ResponseModelList response =
          await NetworkService.get<List>("api/categories/getcategories/197");
      if (response.success) {
        return (response.data.map((e) => CategoryModel.fromJson(e)).toList());
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
    return null;
  }
}
