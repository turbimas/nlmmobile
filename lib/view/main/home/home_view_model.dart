import 'package:flutter/material.dart';
import 'package:dogmar/core/services/auth/authservice.dart';
import 'package:dogmar/core/services/network/network_service.dart';
import 'package:dogmar/core/services/network/response_model.dart';
import 'package:dogmar/core/utils/helpers/popup_helper.dart';
import 'package:dogmar/product/models/category_model.dart';
import 'package:dogmar/product/models/home_banner_model.dart';

class HomeViewModel extends ChangeNotifier {
  bool _homeLoading = true;
  bool get homeLoading => _homeLoading;
  set homeLoading(bool value) {
    _homeLoading = value;
    notifyListeners();
  }

  List<CategoryModel>? categories;
  List<HomeBannerModel>? banners;
  HomeViewModel();

  Future<void> getHomeData() async {
    try {
      homeLoading = true;
      ResponseModelList categoriesResponse =
          await NetworkService.get<List>("categories/getcategories/0");

      ResponseModelList bannersResponse = await NetworkService.get(
          "main/homeviews/${AuthService.currentUser!.id}");

      if (categoriesResponse.success && bannersResponse.success) {
        categories = (categoriesResponse.data)!
            .map((e) => CategoryModel.fromJson(e))
            .toList();
        banners = (bannersResponse.data!)
            .map((e) => HomeBannerModel.fromJson(e))
            .toList();
      } else {
        PopupHelper.showErrorDialog(
            errorMessage: "İnternet bağlatınızı kontrol ediniz.");
      }
    } catch (e) {
      PopupHelper.showErrorDialogWithCode(e);
    } finally {
      homeLoading = false;
    }
  }
}
