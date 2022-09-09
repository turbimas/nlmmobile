import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/order/basket_total_model.dart';
import 'package:nlmmobile/product/models/user/address_model.dart';
import 'package:nlmmobile/view/order/order_success/order_success.dart';

class BasketDetailViewModel extends ChangeNotifier {
  BasketTotalModel basketTotal;
  BasketDetailViewModel({required this.basketTotal, required this.addresses}) {
    _selectedDeliveryAddress = addresses.first;
    _selectedTaxAddress = addresses.first;
  }

  bool _deliveryTaxSame = true;
  bool get deliveryTaxSame => _deliveryTaxSame;
  set deliveryTaxSame(bool value) {
    _deliveryTaxSame = value;
    notifyListeners();
  }

  bool _accepteTerms = false;
  bool get accepteTerms => _accepteTerms;
  set accepteTerms(bool value) {
    _accepteTerms = value;
    notifyListeners();
  }

  List<AddressModel> addresses;

  late AddressModel _selectedDeliveryAddress;
  AddressModel get selectedDeliveryAddress => _selectedDeliveryAddress;
  set selectedDeliveryAddress(AddressModel value) {
    _selectedDeliveryAddress = value;
    if (deliveryTaxSame) {
      _selectedTaxAddress = value;
    }
    notifyListeners();
  }

  late AddressModel _selectedTaxAddress;
  AddressModel get selectedTaxAddress => _selectedTaxAddress;
  set selectedTaxAddress(AddressModel value) {
    _selectedTaxAddress = value;
    notifyListeners();
  }

  Future<void> createOrder() async {
    try {
      if (!accepteTerms) {
        await PopupHelper.showError(
            errorMessage:
                "Sipariş oluşturabilmek için sipariş koşullarını kabul etmelisiniz");
        return;
      }
      ResponseModel response =
          await NetworkService.post("api/orders/createorder", body: {
        "CariID": AuthService.currentUser!.id,
        "DeliveryDate": DateTime.now().toIso8601String(),
        "DeliveryAdressID": selectedDeliveryAddress.id,
        "InvoiceAdressID": selectedTaxAddress.id,
        "OrderNotes": "Sipariş notu"
      });
      if (response.success) {
        NavigationService.navigateToPage(
            OrderSuccessView(orderId: response.data));
      } else {
        await PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }

  // bool _isLoading = false;
  // bool get isLoading => _isLoading;
  // set isLoading(bool value) {
  //   _isLoading = value;
  //   notifyListeners();
  // }

  // Future<void> getAddresses() async {
  //   try {
  //     isLoading = true;
  //     ResponseModel response = await NetworkService.get(
  //         "api/users/adresses/${AuthService.currentUser!.id}");
  //     if (response.success) {
  //       addresses = (response.data as List)
  //           .map((e) => AddressModel.fromJson(e))
  //           .toList();
  //     } else {
  //       PopupHelper.showError(errorMessage: response.errorMessage);
  //     }
  //   } catch (e) {
  //     PopupHelper.showErrorWithCode(e);
  //   } finally {
  //     isLoading = false;
  //   }
  // }
}
