import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/order/basket_data_model.dart';
import 'package:nlmmobile/product/models/order/basket_total_model.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/models/user/address_model.dart';
import 'package:nlmmobile/view/order/basket_detail/basket_detail_view.dart';

class BasketViewModel extends ChangeNotifier {
  BasketViewModel();

  List<ProductOverViewModel> products = [];

  BasketTotalModel? basketTotal;

  ProductOverViewModel? delivery;

  bool _retrieving = false;
  bool get retrieving => _retrieving;
  set retrieving(bool value) {
    _retrieving = value;
    notifyListeners();
  }

  Future<void> getBasket() async {
    retrieving = true;
    try {
      ResponseModelList basketResponse = await NetworkService.get<List>(
          "api/orders/getbasket/${AuthService.currentUser!.id}");
      ResponseModel totalResponse = await NetworkService.get(
          "api/orders/calculatetotals/${AuthService.currentUser!.id}");

      if (basketResponse.success && totalResponse.success) {
        products = basketResponse.data
            .map((e) => BasketDataModel.fromJson(e).product)
            .toList()
            .where((element) => element.barcode != "DELIVERY")
            .map((e) => e)
            .toList();

        basketTotal = BasketTotalModel.fromJson(totalResponse.data);
      } else {
        if (!totalResponse.success) {
          PopupHelper.showError(errorMessage: totalResponse.errorMessage);
        }
        if (!basketResponse.success) {
          PopupHelper.showError(errorMessage: basketResponse.errorMessage);
        }
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    } finally {
      retrieving = false;
    }
  }

  Future<void> goBasketDetail() async {
    try {
      ResponseModel response = await NetworkService.get(
          "api/users/adresses/${AuthService.currentUser!.id}");
      if (response.success) {
        List<AddressModel> addresses = (response.data as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();

        NavigationService.navigateToPage(
            BasketDetailView(basketTotal: basketTotal!, addresses: addresses));
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }
}
