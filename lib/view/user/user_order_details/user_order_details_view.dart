import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';

class UserOrderDetailsView extends ConsumerStatefulWidget {
  const UserOrderDetailsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserOrderDetailsViewState();
}

class _UserOrderDetailsViewState extends ConsumerState<UserOrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar:
            CustomAppBar.activeBack(LocaleKeys.UserOrderDetails_appbar_title),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
            child: Column(
              children: [
                _orderDetails(),
                _deliveryDetails(),
                _paymentDetails(),
                _products(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _orderDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.smh),
      width: 320.smw,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary),
          borderRadius: CustomThemeData.fullRounded,
          color: CustomColors.card2),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
            width: 340.smw,
            height: 40.smh,
            decoration: BoxDecoration(
              color: CustomColors.primary,
              borderRadius: CustomThemeData.topRounded,
            ),
            child: Center(
                child: CustomTextLocale(LocaleKeys.UserOrderDetails_order_info,
                    style: CustomFonts.bodyText3(CustomColors.primaryText))),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
            constraints: BoxConstraints(minHeight: 80.smh),
            width: 340.smw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(LocaleKeys.UserOrderDetails_no,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText("123456789",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_date,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText("12.12.2021",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomText(LocaleKeys.UserOrderDetails_status,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText("Onay Bekliyor",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _deliveryDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.smh),
      width: 320.smw,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary),
          borderRadius: CustomThemeData.fullRounded,
          color: CustomColors.card2),
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
              width: 340.smw,
              height: 40.smh,
              decoration: BoxDecoration(
                color: CustomColors.primary,
                borderRadius: CustomThemeData.topRounded,
              ),
              child: Center(
                  child: CustomTextLocale(
                      LocaleKeys.UserOrderDetails_delivery_info,
                      style: CustomFonts.bodyText3(CustomColors.primaryText)))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
            constraints: BoxConstraints(minHeight: 100.smh),
            width: 340.smw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_date,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText("12.12.2021",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_name,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText("Ahmet Yılmaz",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_phone,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText("0532 123 45 67",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(LocaleKeys.UserOrderDetails_address,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            "390 Nolu CAD. Edacan Sitesi - A Blok/No:16 ŞAHİNBEY/GAZİANTEP",
                            style:
                                CustomFonts.bodyText4(CustomColors.card2Text)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _paymentDetails() {
    return Container(
      margin: EdgeInsets.only(bottom: 15.smh),
      width: 320.smw,
      decoration: BoxDecoration(
          border: Border.all(color: CustomColors.primary),
          borderRadius: CustomThemeData.fullRounded,
          color: CustomColors.card2),
      child: Column(
        children: [
          Container(
              padding:
                  EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
              width: 340.smw,
              height: 40.smh,
              decoration: BoxDecoration(
                color: CustomColors.primary,
                borderRadius: CustomThemeData.topRounded,
              ),
              child: Center(
                  child: CustomTextLocale(
                      LocaleKeys.UserOrderDetails_payment_info,
                      style: CustomFonts.bodyText3(CustomColors.primaryText)))),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
            constraints: BoxConstraints(minHeight: 100.smh),
            width: 340.smw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(LocaleKeys.UserOrderDetails_subtotal,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      CustomText("100 TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(
                          LocaleKeys.UserOrderDetails_delivery_cost,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      CustomText("10 TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(LocaleKeys.UserOrderDetails_total,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      CustomText("110 TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _products() {
    return Container();
  }
}
