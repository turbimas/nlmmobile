import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/models/user/last_searched_model.dart';
import 'package:nlmmobile/product/models/user/last_viewed_model.dart';
import 'package:nlmmobile/view/main/search_result/search_result_view.dart';

class SearchViewModel extends ChangeNotifier {
  int lastSearchCount = 5;
  int lastViewedCount = 5;

  List<LastViewedModel> lastViewed = [];
  List<LastSearchedModel> lastSearched = [];

  SearchViewModel();

  Future<void> getLastData() async {
    try {
      ResponseModelList lastSearches = await NetworkService.get<List>(
          "api/users/last_search_keywords/${AuthService.currentUser!.id}/$lastSearchCount");
      ResponseModelList lastVieweds = await NetworkService.get<List>(
          "api/users/lastviewed/${AuthService.currentUser!.id}/$lastViewedCount");
      if (lastSearches.success && lastVieweds.success) {
        lastSearched = lastSearches.data
            .map((e) => LastSearchedModel.fromJson(e))
            .toList();
        lastViewed =
            lastVieweds.data.map((e) => LastViewedModel.fromJson(e)).toList();
        notifyListeners();
      } else {
        if (!lastSearches.success) {
          PopupHelper.showError(errorMessage: lastSearches.errorMessage);
        }
        if (!lastVieweds.success) {
          PopupHelper.showError(errorMessage: lastVieweds.errorMessage);
        }
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }

  Future<void> searchKeywordDelete(int id) async {
    try {
      ResponseModel lastSearches = await NetworkService.post(
          "api/users/searchkeyworddelete",
          body: [id]);
      if (lastSearches.success) {
        lastSearched.removeWhere((element) => element.id == id);
        notifyListeners();
      } else {
        PopupHelper.showError(errorMessage: lastSearches.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }

  Future<void> deleteAllKeywords() async {
    try {
      ResponseModel lastSearches = await NetworkService.post(
          "api/users/searchkeyworddelete/",
          body: lastSearched.map((e) => e.id).toList());
      if (lastSearches.success) {
        lastSearched.clear();
        notifyListeners();
      } else {
        PopupHelper.showError(errorMessage: lastSearches.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }

  Future<void> search(String searchKey) async {
    try {
      ResponseModel searchResults = await NetworkService.get(
          "api/products/productsearch/${AuthService.currentUser!.id}/$searchKey");

      if (searchResults.success) {
        List products = searchResults.data
            .map((e) => ProductOverViewModel.fromJson(e))
            .toList();
        NavigationService.navigateToPage(
            SearchResultView(products: products, isSearch: true));
      } else {
        PopupHelper.showError(errorMessage: searchResults.errorMessage);
      }

      notifyListeners();
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }
}
