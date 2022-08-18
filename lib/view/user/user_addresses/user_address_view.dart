import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';

class UserAddressView extends ConsumerStatefulWidget {
  const UserAddressView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserAddressViewState();
}

class _UserAddressViewState extends ConsumerState<UserAddressView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
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
                        const Icon(Icons.check_box,
                            color: CustomThemeData.primaryColor),
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
      height: (lines * 50).smh,
      width: 330.smw,
      padding: EdgeInsets.symmetric(horizontal: 20.smw),
      margin: EdgeInsets.only(bottom: 10.smh),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.smh),
          color: CustomThemeData.primaryColor),
      child: TextFormField(
        maxLines: 4,
        style: GoogleFonts.inder(color: Colors.white, fontSize: 15.sp),
        decoration: InputDecoration(
            hintText: hint,
            border: InputBorder.none,
            hintStyle: GoogleFonts.inder(color: Colors.white, fontSize: 15.sp)),
      ),
    );
  }
}
