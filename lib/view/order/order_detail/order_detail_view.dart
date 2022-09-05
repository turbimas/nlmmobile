import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class OrderDetailsView extends ConsumerStatefulWidget {
  const OrderDetailsView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderDetailsViewState();
}

class _OrderDetailsViewState extends ConsumerState<OrderDetailsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(LocaleKeys.OrderDetails_appbar_title),
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
                child: Text(LocaleKeys.OrderDetails_order_info,
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
                      child: Text(LocaleKeys.OrderDetails_no,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text("123456789",
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
                      child: Text(LocaleKeys.OrderDetails_date,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text("12.12.2021",
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
                      child: Text(LocaleKeys.OrderDetails_status,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text("Onay Bekliyor",
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
                  child: Text(LocaleKeys.OrderDetails_delivery_info,
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
                      child: Text(LocaleKeys.OrderDetails_date,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text("12.12.2021",
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
                      child: Text(LocaleKeys.OrderDetails_name,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text("Ahmet Yılmaz",
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
                      child: Text(LocaleKeys.OrderDetails_phone,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text("0532 123 45 67",
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
                      child: Text(LocaleKeys.OrderDetails_address,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: Text(
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
                  child: Text(LocaleKeys.OrderDetails_payment_info,
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
                      Text(LocaleKeys.OrderDetails_subtotal,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      Text("100 TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.OrderDetails_delivery_cost,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      Text("10 TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(LocaleKeys.OrderDetails_total,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      Text("110 TL",
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
