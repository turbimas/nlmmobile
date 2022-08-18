import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/view/user/user_cards/user_card_view.dart';

class UserCardsView extends ConsumerStatefulWidget {
  const UserCardsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserCardsViewState();
}

class _UserCardsViewState extends ConsumerState<UserCardsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      floatingActionButton: _fab(context),
      appBar: CustomAppBar.activeBack("Kartlarım"),
      body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 15.smw, vertical: 25.smh),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _cardContainer(
                    title: "Enpara Şirket Kartım",
                    number: "1234 1234 1234 1234"),
                _cardContainer(
                    title: "Enpara Şirket Kartım",
                    number: "1234 1234 1234 1234"),
                _cardContainer(
                    title: "Enpara Şirket Kartım",
                    number: "1234 1234 1234 1234"),
              ],
            ),
          )),
    ));
  }

  Widget _cardContainer({required String title, required String number}) {
    return Container(
      margin: EdgeInsets.only(bottom: 10.smh),
      height: 65.smh,
      width: 330.smw,
      decoration: const BoxDecoration(
        color: CustomThemeData.primaryColor,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
              height: 65.smh,
              width: 65.smw,
              child: Center(
                child: SvgPicture.asset(AssetConstants.mastercard,
                    height: 25.smh, width: 30.smw),
              )),
          Center(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                Text(title, style: const TextStyle(color: Colors.white)),
                Text(number, style: const TextStyle(color: Colors.white)),
              ])),
          InkWell(
            onTap: () {
              NavigationService.navigateToPage(const UserCardView());
            },
            child: Container(
                decoration: const BoxDecoration(
                    color: CustomThemeData.secondaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                height: 65.smh,
                width: 65.smw,
                child:
                    const Center(child: Icon(Icons.edit, color: Colors.white))),
          ),
        ],
      ),
    );
  }

  InkWell _fab(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const UserCardView()));
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
            const Text("Yeni Kart Ekle", style: TextStyle(color: Colors.white))
          ],
        ),
      ),
    );
  }
}
