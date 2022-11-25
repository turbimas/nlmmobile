import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/category_model.dart';
=======
import 'package:koyevi/core/services/network/network_service.dart';
import 'package:koyevi/core/services/network/response_model.dart';
import 'package:koyevi/core/utils/helpers/popup_helper.dart';
import 'package:koyevi/product/models/category_model.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class CategoriesViewModel extends ChangeNotifier {
  CategoriesViewModel();

  Future<List<CategoryModel>?> getCategories() async {
    try {
      ResponseModelList response =
          await NetworkService.get<List>("categories/getcategories/197");
      if (response.success) {
        return (response.data!.map((e) => CategoryModel.fromJson(e)).toList());
      } else {
        PopupHelper.showErrorDialog(errorMessage: response.errorMessage!);
      }
    } catch (e) {
      PopupHelper.showErrorDialogWithCode(e);
    }
    return null;
  }
}
