import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';
import 'package:nlmmobile/view/user/user_profile/user_profile_view_model.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
  late final ChangeNotifierProvider<UserProfileViewModel> provider;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => UserProfileViewModel(formKey));
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar: CustomAppBar.activeBack("Profilim"),
      body: _body(),
    ));
  }

  Widget _body() {
    return _content();
  }

  Widget _content() {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 15.smw),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20.smh),
                CustomText("Kişisel Bilgiler"),
                SizedBox(height: 20.smh),
                _customTextField(
                    hintText: "Ad Soyad",
                    formKey: "Name",
                    initialValue: AuthService.currentUser!.nameSurname),
                InkWell(
                    onTap: () async {
                      DateTime? result = await showDatePicker(
                          context: context,
                          initialDate: AuthService.currentUser!.birthDate ??
                              DateTime.now(),
                          firstDate: DateTime(1900),
                          lastDate: DateTime(2030));
                      if (result != null) {
                        ref.watch(provider).setReadOnlyFormKey(
                            "BornDate", result.toString().split(" ")[0]);
                        log(ref.watch(provider).formData.toString());
                      }
                    },
                    child: _customReadOnlyField(
                        readKey: "BornDate",
                        hint: "Doğum tarihi",
                        initialValue: AuthService.currentUser!.birthDate
                            ?.toString()
                            .split(" ")[0])),
                _customTextField(
                    hintText: "Telefon numarası",
                    formKey: "MobilePhone",
                    initialValue:
                        (AuthService.currentUser!.phone ?? "").toString()),
                _customTextField(
                    hintText: "E-posta",
                    formKey: "Email",
                    initialValue: AuthService.currentUser!.email),
                _customTextField(
                    hintText: "Şifre",
                    formKey: "Password",
                    initialValue: AuthService.currentUser!.password,
                    obscureText: true)
              ],
            ),
          ),
          OkCancelPrompt(
              okCallBack: ref.read(provider).save,
              cancelCallBack: () {
                NavigationService.back();
              })
        ],
      ),
    );
  }

  Widget _customReadOnlyField(
      {required String hint, required String readKey, String? initialValue}) {
    if (initialValue != null && ref.watch(provider).formData[readKey] == null) {
      ref.read(provider).formData[readKey] = initialValue;
    }
    String value = ref.watch(provider).formData[readKey] ?? "";
    if (value.isEmpty) {
      value = hint;
    }
    return Container(
        margin: EdgeInsets.symmetric(vertical: 5.smh),
        width: 330.smw,
        height: 50.smh,
        padding: EdgeInsets.symmetric(horizontal: 10.smw),
        decoration: BoxDecoration(
            borderRadius: CustomThemeData.fullInfiniteRounded,
            color: CustomColors.primary),
        child: Align(
            alignment: Alignment.centerLeft,
            child: CustomText(value,
                style: CustomFonts.bodyText4(CustomColors.primaryText))));
  }

  Widget _customTextField(
      {required String hintText,
      required String formKey,
      bool obscureText = false,
      String? initialValue}) {
    return Container(
      width: 330.smw,
      height: 50.smh,
      margin: EdgeInsets.symmetric(vertical: 5.smh),
      decoration: BoxDecoration(
          borderRadius: CustomThemeData.fullInfiniteRounded,
          color: CustomColors.primary),
      child: Center(
          child: TextFormField(
        obscureText: obscureText,
        onSaved: (value) {
          ref.read(provider).formData[formKey] = value;
        },
        initialValue: initialValue,
        style: CustomFonts.bodyText4(CustomColors.primaryText),
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: CustomFonts.bodyText4(CustomColors.primaryText),
            border: OutlineInputBorder(
                borderRadius: CustomThemeData.fullInfiniteRounded,
                borderSide: BorderSide.none)),
      )),
    );
  }
}
