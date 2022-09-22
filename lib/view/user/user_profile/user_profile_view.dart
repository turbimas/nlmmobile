import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';

class UserProfileView extends ConsumerStatefulWidget {
  const UserProfileView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserProfileViewState();
}

class _UserProfileViewState extends ConsumerState<UserProfileView> {
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
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.smw),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText("Kişisel Bilgiler"),
              _customTextField(hintText: "Ad Soyad", formKey: "nameSurname"),
              InkWell(
                  onTap: () {
                    showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1900),
                        lastDate: DateTime(2022));
                  },
                  child: AbsorbPointer(
                      child: _customTextField(
                          hintText: "Doğum Tarihi", formKey: ""))),
            ],
          ),
        ),
        OkCancelPrompt(okCallBack: () {}, cancelCallBack: () {})
      ],
    );
  }

  Widget _customTextField({required String hintText, required String formKey}) {
    return Container(
      width: 330.smw,
      decoration: BoxDecoration(
          borderRadius: CustomThemeData.fullInfiniteRounded,
          color: CustomColors.primary),
      child: Center(
          child: TextFormField(
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
