import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
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
        PopupHelper.showError(message: response.message);
      }
    } catch (e) {
      PopupHelper.showError(message: "${LocaleKeys.ErrorCodes_ERROR.tr()}\n$e");
    }
    return null;
  }
}
