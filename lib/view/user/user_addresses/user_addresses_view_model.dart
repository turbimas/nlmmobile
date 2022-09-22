import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/product/models/user/address_model.dart';

class UserAddressesViewModel extends ChangeNotifier {
  UserAddressesViewModel();
  List<AddressModel>? addresses;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> getAddresses() async {
    try {
      isLoading = true;
      ResponseModel response = await NetworkService.get(
          "api/users/adresses/${AuthService.currentUser!.id}");
      if (response.success) {
        addresses = (response.data as List)
            .map((e) => AddressModel.fromJson(e))
            .toList();
      }
    } finally {
      isLoading = false;
    }
  }
}
