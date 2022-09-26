import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/user/user_orders_model.dart';

class UserOrdersViewModel extends ChangeNotifier {
  List<UserOrdersModel> filtered = [];

  List<UserOrdersModel> orders = [];
  List<String> statuses = [];
  Set<String> filterStatuses = {};
  UserOrdersViewModel();

  Future<void> getOrders() async {
    try {
      ResponseModel response = await NetworkService.get(
          "api/users/orders/${AuthService.currentUser!.id}");
      if (response.success) {
        orders = (response.data as List)
            .map((e) => UserOrdersModel.fromJson(e))
            .toList();
        statuses = orders.map<String>((e) => e.statusName).toSet().toList();
        filtered = orders;
        filterStatuses = statuses.toSet();
        notifyListeners();
      } else {
        PopupHelper.showErrorDialog(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorDialogWithCode(e);
    }
  }

  void addRemoveFilter(String status) {
    if (filterStatuses.contains(status)) {
      filterStatuses.remove(status);
    } else {
      filterStatuses.add(status);
    }
    filtered = orders
        .where((element) => filterStatuses.contains(element.statusName))
        .toList();
    notifyListeners();
  }
}
