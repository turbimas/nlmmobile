import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/category_model.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/view/main/search_result/search_result_view.dart';

class SubCategoriesViewModel extends ChangeNotifier {
  ScrollController scrollController;
  List<CategoryModel> selectedCategories = [];
  List<List<CategoryModel>> subCategories = [];

  CategoryModel? masterCategory;
  List<CategoryModel>? masterCategories;

  SubCategoriesViewModel(
      {required this.scrollController,
      this.masterCategory,
      this.masterCategories}) {
    if (masterCategory != null && masterCategories != null) {
      getSubCategories(masterCategory!);
    } else {
      getMasterCategories().then((value) {
        getSubCategories(masterCategories!.first);
      });
    }
  }

  bool _retrieving = false;
  bool get retrieving => _retrieving;
  set retrieving(bool value) {
    _retrieving = value;
    notifyListeners();
  }

  Future<void> getMasterCategories() async {
    try {
      retrieving = true;
      ResponseModelList response =
          await NetworkService.get<List>("api/categories/getcategories/197");
      if (response.success) {
        masterCategories =
            response.data.map((e) => CategoryModel.fromJson(e)).toList();
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    } finally {
      retrieving = false;
    }
  }

  Future<void> getSubCategories(CategoryModel model) async {
    try {
      int index = selectedCategories
          .indexWhere((element) => model.upperGroupId == element.upperGroupId);
      if (index > -1) {
        selectedCategories.removeRange(index, selectedCategories.length);
        subCategories.removeRange(index, subCategories.length);
      }
      retrieving = true;
      ResponseModelList response = await NetworkService.get<List>(
          "api/categories/getcategories/${model.id}");
      if (response.success) {
        List<CategoryModel> responseList =
            response.data.map((e) => CategoryModel.fromJson(e)).toList();
        subCategories.add(responseList);
        selectedCategories.add(model);
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    } finally {
      retrieving = false;
      Future.delayed(const Duration(milliseconds: 100), () {
        scrollController.animateTo(
            curve: Curves.easeOut,
            duration: const Duration(milliseconds: 100),
            scrollController.position.maxScrollExtent);
      });
    }
  }

  Future<void> approve() async {
    try {
      retrieving = true;
      ResponseModelList responseModel = await NetworkService.get<List>(
          "api/categories/getCategoryMembers/${AuthService.currentUser!.id}/${selectedCategories.last.id}");
      if (responseModel.success) {
        List<ProductOverViewModel> products = responseModel.data.map((e) {
          return ProductOverViewModel.fromJson(e["Product"]);
        }).toList();
        NavigationService.navigateToPage(SearchResultView(
            products: products,
            categoryModel: masterCategory,
            masterCategories: masterCategories));
      } else {
        PopupHelper.showError(errorMessage: responseModel.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    } finally {
      retrieving = false;
    }
  }

  void cancel() {
    NavigationService.back();
  }
}
