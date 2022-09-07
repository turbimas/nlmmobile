import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/user/user_rating_model.dart';

class UserRatingsViewModel extends ChangeNotifier {
  List<UserRatingModel> rated = [];
  List<UserRatingModel> unrated = [];

  int _index = 0;
  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;
      notifyListeners();
    }
  }

  UserRatingsViewModel();

  Future<void> getRated() async {
    try {
      ResponseModel response = await NetworkService.get(
          "api/users/evaluated/${AuthService.currentUser!.id}");
      if (response.success) {
        rated = (response.data as List)
            .map((e) => UserRatingModel.fromJson(e))
            .toList();

        notifyListeners();
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }
}
