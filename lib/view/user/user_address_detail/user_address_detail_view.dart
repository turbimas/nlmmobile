import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';

class UserAddressDetailView extends ConsumerStatefulWidget {
  const UserAddressDetailView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserAddressDetailViewState();
}

class _UserAddressDetailViewState extends ConsumerState<UserAddressDetailView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.activeBack("Adres ekle"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Form(
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: [
                Container(
                    width: 330.smw,
                    height: 30.smh,
                    margin: EdgeInsets.symmetric(vertical: 20.smh),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomIcons.checkbox_checked_icon,
                        SizedBox(width: 5.smw),
                        const Text("Aktif")
                      ],
                    )),
                _customTextField(hint: "Adres Başlığı Girin"),
                _customTextField(hint: "İl"),
                _customTextField(hint: "İlçe"),
                _customTextField(hint: "Adres", lines: 2),
              ]),
            ),
            OkCancelPrompt(okCallBack: () {}, cancelCallBack: () {})
          ],
        ),
      ),
    );
  }

  Widget _customTextField({required String hint, int lines = 1}) {
    return Container(
      constraints: BoxConstraints(minHeight: (lines * 50).smh),
      width: 330.smw,
      padding: EdgeInsets.symmetric(horizontal: 20.smw),
      margin: EdgeInsets.only(bottom: 10.smh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.smh),
          color: CustomColors.primary),
      child: TextFormField(
        style: CustomFonts.defaultField(CustomColors.primaryText),
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: CustomFonts.defaultField(CustomColors.primaryText)),
      ),
    );
  }
}
