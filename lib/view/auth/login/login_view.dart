import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/constants/navigation_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomAppBar.inactiveBack("Giriş Yap"),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 105.smh, bottom: 55.smh, left: 70.smw, right: 70.smw),
              child: InteractiveViewer(
                maxScale: 10,
                child: SvgPicture.asset(AssetConstants.login_image,
                    height: 220.smh, width: 220.smw),
              ),
            ),
            Container(
              height: 50.smh,
              width: 300.smw,
              decoration: const BoxDecoration(
                  color: CustomThemeData.primaryColor,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Padding(
                  padding: EdgeInsets.only(
                      left: 20.smw, top: 8.smh, bottom: 7.smh, right: 20.smw),
                  child: TextFormField(
                    textAlignVertical: TextAlignVertical.center,
                    textAlign: TextAlign.left,
                    style:
                        GoogleFonts.inder(fontSize: 12.sp, color: Colors.white),
                    decoration: InputDecoration(
                        isCollapsed: true,
                        border: InputBorder.none,
                        hintStyle: GoogleFonts.inder(
                            fontSize: 12.sp, color: Colors.white),
                        hintText: "Kullanıcı adı,e-posta yada telefon girin",
                        prefixIcon: Padding(
                          padding: EdgeInsets.only(right: 10.smw),
                          child: SvgPicture.asset(AssetConstants.username_icon,
                              height: 35.smh, width: 35.smw),
                        )),
                  )),
            ),
            SizedBox(height: 15.smh),
            Container(
                height: 50.smh,
                width: 300.smw,
                decoration: const BoxDecoration(
                    color: CustomThemeData.primaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Padding(
                    padding: EdgeInsets.only(
                        left: 20.smw, top: 8.smh, bottom: 7.smh, right: 20.smw),
                    child: TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      textAlign: TextAlign.left,
                      style: GoogleFonts.inder(
                          fontSize: 12.sp, color: Colors.white),
                      decoration: InputDecoration(
                          isCollapsed: true,
                          border: InputBorder.none,
                          hintStyle: GoogleFonts.inder(
                              fontSize: 12.sp, color: Colors.white),
                          hintText: "Şifre girin",
                          prefixIcon: Padding(
                            padding: EdgeInsets.only(right: 10.smw),
                            child: SvgPicture.asset(
                                AssetConstants.password_icon,
                                height: 35.smh,
                                width: 35.smw),
                          )),
                    ))),
            SizedBox(height: 5.smh),
            SizedBox(
                width: 300.smw,
                height: 25.smh,
                child: const Align(
                    alignment: Alignment.centerRight,
                    child: Text("Şifrenizi mi Unuttunuz ?"))),
            Padding(
              padding: EdgeInsets.only(
                  top: 15.smh, left: 45.smw, right: 45.smw, bottom: 0.smh),
              child: InkWell(
                onTap: () => NavigationService.navigateToNameReplace(
                    NavigationConstants.mainView),
                child: Container(
                  height: 75.smh,
                  width: 270.smw,
                  decoration: const BoxDecoration(
                    color: CustomThemeData.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(45)),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30.smw),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Giriş yap",
                            style: GoogleFonts.inder(
                                color: Colors.white, fontSize: 20.sp)),
                        const Icon(Icons.arrow_forward_ios, color: Colors.white)
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding:
                  EdgeInsets.only(top: 35.smh, left: 140.smw, bottom: 25.smh),
              child: InkWell(
                onTap: () => NavigationService.navigateToName(
                    NavigationConstants.register),
                child: Container(
                  height: 75.smh,
                  width: 220.smw,
                  decoration: const BoxDecoration(
                      color: CustomThemeData.primaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(45),
                          bottomLeft: Radius.circular(45))),
                  child: Center(
                      child: Text("Kayıt Ol",
                          style: GoogleFonts.inder(
                              fontSize: 20.sp, color: Colors.white))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
