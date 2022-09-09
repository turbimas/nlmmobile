import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/models/order/order_detail_row.dart';
import 'package:nlmmobile/product/models/user/user_orders_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_circular.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';
import 'package:nlmmobile/product/widgets/try_again_widget.dart';
import 'package:nlmmobile/view/user/user_order_details/user_order_details_view_model.dart';

class UserOrderDetailsView extends ConsumerStatefulWidget {
  final UserOrdersModel orderTitle;
  const UserOrderDetailsView({Key? key, required this.orderTitle})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _UserOrderDetailsViewState();
}

class _UserOrderDetailsViewState extends ConsumerState<UserOrderDetailsView> {
  late final ChangeNotifierProvider<UserOrderDetailsViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider(
        (ref) => UserOrderDetailsViewModel(orderTitle: widget.orderTitle));
    Future.delayed(Duration.zero, () {
      ref.read(provider).getDetails();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack(
            LocaleKeys.UserOrderDetails_appbar_title.tr()),
        body: _body(),
      ),
    );
  }

  Widget _body() {
    return ref.watch(provider).isLoading
        ? _loading()
        : ref.watch(provider).orderLines == null
            ? TryAgain(
                callBack: ref.read(provider).getDetails,
              )
            : _content();
  }

  Widget _loading() {
    return const Center(
      child: CustomCircularProgressIndicator(),
    );
  }

  Widget _content() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 10.smh),
        child: Column(
          children: [
            _orderDetails(),
            _deliveryDetails(),
            _invoiceDetails(),
            _paymentDetails(),
            _productsHeader(),
            const Divider(),
            ..._products(),
          ],
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_no,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(widget.orderTitle.FicheNo,
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_date,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.OrderDate.toString(),
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
                      flex: 2,
                      child: CustomTextLocale(
                          LocaleKeys.UserOrderDetails_status,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(widget.orderTitle.StatusName,
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_date,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.DeliveryAdressDetail.deliveryDate
                                .toString(),
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_name,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.DeliveryAdressDetail
                                    .relatedPerson ??
                                "-",
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_phone,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.DeliveryAdressDetail.phone ?? "-",
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
                      flex: 2,
                      child: CustomTextLocale(
                          LocaleKeys.UserOrderDetails_address,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.DeliveryAdressDetail.address ??
                                "-",
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

  Widget _invoiceDetails() {
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
                  child: CustomText("Fatura Bilgileri",
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_name,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.InvoiceAdressDetail
                                    .RelatedPerson ??
                                "-",
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
                      flex: 2,
                      child: CustomTextLocale(LocaleKeys.UserOrderDetails_phone,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.InvoiceAdressDetail.MobilePhone ??
                                "-",
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
                      flex: 2,
                      child: CustomText("Vergi dairesi",
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.InvoiceAdressDetail.TaxOffice ??
                                "-",
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
                      flex: 2,
                      child: CustomText(
                          widget.orderTitle.InvoiceAdressDetail.isPerson ??
                                  false
                              ? "T.C. Kimlik No"
                              : "Vergi No",
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.InvoiceAdressDetail.isPerson ??
                                    false
                                ? widget.orderTitle.InvoiceAdressDetail.TCKNo ??
                                    "-"
                                : widget.orderTitle.InvoiceAdressDetail
                                        .TaxNumber ??
                                    "-",
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
                      flex: 2,
                      child: CustomTextLocale(
                          LocaleKeys.UserOrderDetails_address,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                    ),
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsets.only(left: 30.smw),
                        child: CustomText(
                            widget.orderTitle.InvoiceAdressDetail.Address ??
                                "-",
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
                      CustomText(
                          "${widget.orderTitle.OrderTotals.lineTotal.toStringAsFixed(2)} TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(
                          LocaleKeys.UserOrderDetails_delivery_cost,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      CustomText(
                          "${widget.orderTitle.OrderTotals.deliveryTotal.toStringAsFixed(2)} TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(LocaleKeys.UserOrderDetails_total,
                          style: CustomFonts.bodyText4(
                              CustomColors.card2TextPale)),
                      CustomText(
                          "${widget.orderTitle.OrderTotals.generalTotal.toStringAsFixed(2)} TL",
                          style: CustomFonts.bodyText4(CustomColors.card2Text)),
                    ]),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _productsHeader() {
    return Container(
      width: AppConstants.designWidth.smw,
      margin: EdgeInsets.only(top: 10.smh, bottom: 5.smh),
      child: Center(
        child: CustomTextLocale(
          LocaleKeys.UserOrderDetails_products,
          style: CustomFonts.bodyText2(CustomColors.backgroundText),
        ),
      ),
    );
  }

  List<Widget> _products() {
    return List.generate(ref.watch(provider).orderLines!.length,
        (index) => _productCard(ref.watch(provider).orderLines![index]));
  }

  Widget _productCard(OrderLinesModel linesModel) {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.card,
          border: Border.all(color: CustomColors.primary),
          borderRadius: CustomThemeData.fullRounded),
      padding: EdgeInsets.symmetric(horizontal: 5.smw, vertical: 10.smh),
      margin: EdgeInsets.symmetric(vertical: 10.smh),
      height: 150.smh,
      width: 330.smw,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ProductOverViewHorizontalView(product: linesModel.product),
          SizedBox(height: 20.smh),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.smw),
            child: CustomText("Miktar: ${linesModel.amount}",
                style: CustomFonts.bodyText4(CustomColors.cardTextPale)),
          ),
        ],
      ),
    );
  }
}
