import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/user_model.dart';
import 'package:nlmmobile/view/auth/validation/validation_view.dart';

class UserProfileViewModel extends ChangeNotifier {
  Map<String, dynamic> formData = {};
  Map<String, dynamic> readOnlyFormData = {};

  GlobalKey<FormState> formKey;

  UserProfileViewModel(this.formKey);

  void setReadOnlyFormKey(String key, dynamic data) {
    formData[key] = data;
    notifyListeners();
  }

  Future<void> save() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      if (AuthService.currentUser!.email != formData["Email"]) {
        NavigationService.navigateToPage(ValidationView(
          registerData: {
            "Name": AuthService.currentUser!.nameSurname,
            "MobilePhone": AuthService.currentUser!.phone,
            "Email": formData["Email"],
            "Password": formData["Password"],
          },
          isUpdate: true,
        ));
      } else {
        formData["Password"] = AuthService.currentUser!.password;
        formData["ID"] = AuthService.currentUser!.id;
        ResponseModel response =
            await NetworkService.post("users/user_edit", body: formData);
        if (response.success) {
          PopupHelper.showSuccessToast("Başarıyla güncellendi");
          ResponseModel response =
              await NetworkService.get("users/user_info/${formData["Email"]}");
          if (response.success) {
            UserModel user = UserModel.fromJson(response.data);
            AuthService.login(user);
          } else {
            AuthService.logout();
          }
        } else {
          PopupHelper.showErrorDialog(errorMessage: response.errorMessage!);
        }
      }
      formKey.currentState!.save();
    }
  }
}
