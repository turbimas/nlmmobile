import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/view/order/order_detail/order_detail_view.dart';
import 'package:nlmmobile/view/user/user_orders/user_orders_view_model.dart';

class UserOrdersView extends ConsumerStatefulWidget {
  const UserOrdersView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends ConsumerState<UserOrdersView> {
  late ChangeNotifierProvider<UserOrdersViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => UserOrdersViewModel());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(LocaleKeys.UserOrders_appbar_title),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [_filters(), _cards()],
        ),
      ),
    );
  }

  Widget _filters() {
    return const SizedBox(height: 0, width: 0);
  }

  Widget _cards() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: ref.watch(provider).filtered.length,
        itemBuilder: (context, index) => _card(index));
  }

  Widget _card(int index) {
    return InkWell(
      onTap: () {
        NavigationService.navigateToPage(const OrderDetailsView());
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
        margin: EdgeInsets.only(bottom: 10.smh),
        height: 200.smh,
        width: AppConstants.designWidth.smw,
        color: CustomColors.card2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:
                  EdgeInsets.only(left: 10.smw, right: 10.smw, top: 10.smh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text.rich(TextSpan(
                          text: "No: ",
                          style:
                              CustomFonts.bodyText4(CustomColors.card2TextPale),
                          children: [
                            TextSpan(
                                text: "123456789",
                                style: CustomFonts.bodyText4(
                                    CustomColors.card2Text))
                          ])),
                      Text.rich(TextSpan(
                          text: "Tarih: ",
                          style:
                              CustomFonts.bodyText4(CustomColors.card2TextPale),
                          children: [
                            TextSpan(
                                text: "12/12/2020",
                                style: CustomFonts.bodyText4(
                                    CustomColors.card2Text))
                          ])),
                      Text.rich(TextSpan(
                          text: "Durum: ",
                          style:
                              CustomFonts.bodyText4(CustomColors.card2TextPale),
                          children: [
                            TextSpan(
                                text: "Onaylandı",
                                style: CustomFonts.bodyText4(
                                    CustomColors.card2Text))
                          ])),
                    ],
                  ),
                  Column(// resim ve ürün sayısı
                      children: [
                    Text("Sipariş tutarı",
                        style:
                            CustomFonts.bodyText4(CustomColors.card2TextPale)),
                    Text("400,00 TL",
                        style: CustomFonts.bodyText3(CustomColors.card2Text)),
                  ])
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(right: 5.smw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5.smh),
                        child: ClipRRect(
                          borderRadius: CustomThemeData.fullRounded,
                          child: Image.network("https://picsum.photos/200",
                              height: 90.smh, width: 90.smh),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(5.smh),
                        child: ClipRRect(
                          borderRadius: CustomThemeData.fullRounded,
                          child: Image.network("https://picsum.photos/200",
                              height: 90.smh, width: 90.smh),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text("+ 8\nÜrün\nDaha",
                          style: CustomFonts.bodyText1(CustomColors.card2Text)),
                      SizedBox(width: 20.smw),
                      CustomIcons.forward_icon_dark
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
