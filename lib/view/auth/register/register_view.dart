import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class RegisterView extends ConsumerStatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _RegisterViewState();
}

class _RegisterViewState extends ConsumerState<RegisterView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.inactiveBack("Register"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 25.smh),
            Center(
                child: SvgPicture.asset(AssetConstants.register_image,
                    height: 150.smh, width: 220.smw)),
            SizedBox(height: 70.smh),
            Form(
                child: Column(
              children: [
                _customTextField(
                    label: "Kullanıcı adı",
                    icon: const Icon(Icons.person, color: Colors.white)),
                _customTextField(
                    label: "Telefon",
                    icon: const Icon(Icons.phone, color: Colors.white)),
                _customTextField(
                    label: "E-Mail",
                    icon: const Icon(Icons.email, color: Colors.white)),
                _customTextField(
                    label: "Şifre",
                    icon: const Icon(Icons.lock, color: Colors.white)),
              ],
            )),
            const SizedBox(height: 10),
            SizedBox(
              height: 30.smh,
              width: AppConstants.designWidth.smw,
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SvgPicture.asset(AssetConstants.checkbox_checked,
                    height: 30.smh, width: 30.smw),
                SizedBox(width: 5.smw),
                Text("Üyelik sözleşmesini okudum ve kabul ediyorum.",
                    style:
                        GoogleFonts.inder(color: Colors.black, fontSize: 14.sp))
              ]),
            ),
            SizedBox(height: 35.smh),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 30.smw),
              height: 75.smh,
              width: 270.smw,
              decoration: const BoxDecoration(
                  color: CustomThemeData.secondaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(45))),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Kayıt Ol",
                        style: GoogleFonts.inder(
                            color: Colors.white, fontSize: 20.sp)),
                    const Icon(Icons.arrow_forward_ios, color: Colors.white),
                  ]),
            )
          ],
        ),
      ),
    );
  }

  Container _customTextField({required String label, required Icon icon}) {
    return Container(
      height: 50.smh,
      width: 330.smw,
      decoration: const BoxDecoration(
          color: CustomThemeData.primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(50))),
      margin: EdgeInsets.only(bottom: 10.smh),
      child: Center(
        child: TextFormField(
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
            prefixIcon: icon,
            hintText: label,
            isCollapsed: true,
            border: InputBorder.none,
            hintStyle: GoogleFonts.inder(color: Colors.white, fontSize: 12.sp),
          ),
          style: GoogleFonts.inder(color: Colors.white, fontSize: 12.sp),
        ),
      ),
    );
  }
}
