import 'dart:math' as math;

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/user_model.dart';

class ValidationViewModel extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool _resented = false;
  bool get resented => _resented;
  set resented(bool value) {
    _resented = value;
    notifyListeners();
  }

  Map<String, dynamic> registerData;
  ValidationViewModel(this.registerData) {
    generateValidateCode();
  }

  String validateCode = "";

  String approvedValidationCode = "";

  void generateValidateCode() {
    validateCode = "";
    for (int i = 0; i < 6; i++) {
      validateCode += math.Random().nextInt(10).toString();
    }
  }

  Future<bool> sendMail() async {
    try {
      ResponseModel response =
          await NetworkService.post("api/users/email_verification", body: {
        "Email": registerData["Email"],
        "NameSurname": registerData["Name"],
        "VerificationCode": validateCode
      });
      if (response.success) {
        return true;
      } else {
        PopupHelper.showError(
            message: response.message,
            dismissible: false,
            actions: [
              {
                "text": LocaleKeys.Validation_go_back.tr(),
                "onPressed": () {
                  NavigationService.back(times: 2);
                }
              }
            ]);
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> resend() async {
    generateValidateCode();
    resented = await sendMail();
  }

  Future<void> approve() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (approvedValidationCode == validateCode) {
        ResponseModel response =
            await NetworkService.post("api/users/register", body: registerData);
        if (response.success) {
          ResponseModel userInfo = await NetworkService.get(
              "api/users/user_info/${registerData["Email"]}");
          if (userInfo.success) {
            formKey.currentState?.dispose();
            await AuthService.login(UserModel.fromJson(userInfo.data));
          } else {
            PopupHelper.showError(message: userInfo.message);
          }
        } else {
          PopupHelper.showError(message: response.message);
        }
      } else {
        PopupHelper.showError(message: LocaleKeys.Validation_wrong_code.tr());
      }
    }
  }
}
