import 'package:flutter/material.dart';
import 'package:nlmdev/core/services/auth/authservice.dart';
import 'package:nlmdev/core/services/navigation/navigation_service.dart';
import 'package:nlmdev/core/services/network/network_service.dart';
import 'package:nlmdev/core/services/network/response_model.dart';
import 'package:nlmdev/core/utils/helpers/popup_helper.dart';
import 'package:nlmdev/product/models/user_model.dart';
import 'package:nlmdev/product/widgets/main/main_view.dart';

class LoginViewModel extends ChangeNotifier {
  GlobalKey<FormState> formKey;
  LoginViewModel({required this.formKey});

  bool _isHiding = true;
  bool get isHiding => _isHiding;
  set isHiding(bool value) {
    _isHiding = value;
    notifyListeners();
  }

  Future<void> login(
      {required String loginInfo, required String password}) async {
    // TODO : Validation uygulanacak
    ResponseModel loginResponse =
        await NetworkService.get("users/login/$loginInfo/$password");
    if (loginResponse.success) {
      ResponseModel userResponse =
          await NetworkService.get("users/user_info/$loginInfo");
      if (userResponse.success) {
        UserModel user = UserModel.fromJson(userResponse.data);
        AuthService.login(user);
        NavigationService.navigateToPageAndRemoveUntil(const MainView());
      } else {
        PopupHelper.showErrorDialog(errorMessage: userResponse.errorMessage!);
      }
    } else {
      PopupHelper.showErrorDialog(errorMessage: loginResponse.errorMessage!);
    }
  }
}
