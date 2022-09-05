import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/view/user/user_address_detail/user_address_detail_view.dart';

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
        appBar: CustomAppBar.activeBack(LocaleKeys.UserAddresses_add_address),
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const UserAddressDetailView()));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
        margin: EdgeInsets.only(right: 15.smw, bottom: 15.smh),
        height: 50.smh,
        width: 165.smw,
        decoration: BoxDecoration(
            color: CustomColors.primary,
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
            Text(LocaleKeys.UserAddresses_add_address,
                style: CustomFonts.bodyText4(CustomColors.primaryText))
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
      padding: EdgeInsets.symmetric(vertical: 5.smh),
      margin: EdgeInsets.only(bottom: 10.smh),
      width: 330.smw,
      decoration: BoxDecoration(
          color: CustomColors.primary, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          SizedBox(
              width: 70.smw,
              child: Center(
                child: isSelected
                    ? CustomIcons.radio_checked_light_icon
                    : CustomIcons.radio_unchecked_light_icon,
              )),
          Container(
              padding: EdgeInsets.symmetric(vertical: 5.smh),
              width: 210.smw,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: CustomFonts.bodyText3(CustomColors.primaryText)),
                  Text(subtitle,
                      style: CustomFonts.bodyText4(CustomColors.primaryText))
                ],
              )),
          InkWell(
            onTap: () {
              NavigationService.navigateToPage(const UserAddressDetailView());
            },
            child: SizedBox(
              width: 50.smw,
              child: CustomIcons.edit_icon__medium,
            ),
          )
        ],
      ),
    );
  }
}
