import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/order/basket_data_model.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';

class BasketViewModel extends ChangeNotifier {
  BasketViewModel();

  List<ProductOverViewModel> products = [];
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
      ResponseModelList response = await NetworkService.get<List>(
          "api/orders/getbasket/${AuthService.currentUser!.id}");
      if (response.success) {
        products = response.data
            .map((e) => BasketDataModel.fromJson(e))
            .toList()
            .where((element) => element.product.barcode != "DELIVERY")
            .map((e) => e.product)
            .toList();
      } else {
        PopupHelper.showError(message: response.message);
      }
    } finally {
      retrieving = false;
    }
  }
}
