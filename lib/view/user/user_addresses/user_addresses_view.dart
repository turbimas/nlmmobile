import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/view/user/user_addresses/user_address_view.dart';

class UserAddressesView extends ConsumerStatefulWidget {
  const UserAddressesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserAddressesViewState();
}

class _UserAddressesViewState extends ConsumerState<UserAddressesView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        floatingActionButton: _fab(context),
        appBar: CustomAppBar.activeBack("Adreslerim"),
        body: Padding(
          padding: EdgeInsets.only(
              bottom: 15.smh, right: 15.smw, left: 15.smw, top: 25.smh),
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            _radioButtonWithEdit(
                title: "Ofis",
                subtitle:
                    "Güvenevler Mah. 28 Nolu Sk. No:5 Şehitkamil / Gaziantep",
                isSelected: true),
            _radioButtonWithEdit(
                title: "Ev",
                subtitle:
                    "Şahintepe Mah. 390 Nolu Cad. Edacan Sitesi A/16 Şahinbey / Gaziantep",
                isSelected: false),
          ]),
        ),
      ),
    );
  }

  InkWell _fab(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserAddressView()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
        margin: EdgeInsets.only(right: 15.smw, bottom: 15.smh),
        height: 50.smh,
        width: 165.smw,
        decoration: BoxDecoration(
            color: CustomThemeData.primaryColor,
            borderRadius: BorderRadius.circular(15)),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(5),
                      bottomLeft: Radius.circular(5),
                      topRight: Radius.circular(5),
                    )),
                height: 25.smh,
                width: 25.smw,
                child: const Icon(Icons.add)),
            const Text("Yeni Adres Ekle", style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }

  _radioButtonWithEdit(
      {required String title,
      required String subtitle,
      required bool isSelected}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.smh),
      height: 65.smh,
      width: 330.smw,
      decoration: BoxDecoration(
          color: CustomThemeData.primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          SizedBox(
              width: 70.smw,
              height: 65.smh,
              child: Center(
                  child: SvgPicture.asset(
                      isSelected
                          ? AssetConstants.radio_button_checked
                          : AssetConstants.radio_button_unchecked,
                      height: 25.smh,
                      width: 25.smw,
                      color: Colors.white))),
          Container(
              padding: EdgeInsets.symmetric(vertical: 5.smh),
              width: 210.smw,
              height: 65.smh,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: GoogleFonts.inder(
                          fontSize: 12.sp, color: Colors.white)),
                  Text(subtitle,
                      style: GoogleFonts.inder(
                          fontSize: 12.sp, color: Colors.white))
                ],
              )),
          SizedBox(
            width: 50.smw,
            height: 65.smh,
            child: const Icon(Icons.edit, color: Colors.white),
          )
        ],
      ),
    );
  }
}
