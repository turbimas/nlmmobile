import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/models/order/basket_total_model.dart';
import 'package:nlmmobile/product/models/user/address_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/view/order/basket_detail/basket_detail_view_model.dart';

class BasketDetailView extends ConsumerStatefulWidget {
  final BasketTotalModel basketTotal;
  final List<AddressModel> addresses;
  const BasketDetailView(
      {Key? key, required this.basketTotal, required this.addresses})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasketDetailState();
}

class _BasketDetailState extends ConsumerState<BasketDetailView> {
  late final ChangeNotifierProvider<BasketDetailViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => BasketDetailViewModel(
        basketTotal: widget.basketTotal, addresses: widget.addresses));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar:
          CustomAppBar.activeBack(LocaleKeys.BasketDetail_appbar_title.tr()),
      body: _body(),
    ));
  }

  Widget _body() {
    return Stack(
      children: [
        Positioned(
          top: 0,
          left: 15.smw,
          right: 15.smw,
          bottom: 0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 10.smh),
                _deliveryAddress(),
                SizedBox(height: 15.smh),
                _addressEquality(),

                ref.watch(provider).deliveryTaxSame
                    ? Container()
                    : SizedBox(height: 15.smh),
                ref.watch(provider).deliveryTaxSame
                    ? Container()
                    : _taxAddress(),
                SizedBox(height: 15.smh),
                _deliveryTime(),
                SizedBox(height: 15.smh),
                _paymentType(),
                SizedBox(height: 15.smh),
                InkWell(
                  onTap: () {
                    ref.read(provider).accepteTerms =
                        !ref.read(provider).accepteTerms;
                  },
                  child: _optionTile(
                      title: "Sipariş koşullarını okudum ve kabul ediyorum",
                      checked: ref.watch(provider).accepteTerms),
                ),
                // ..._optionsList(),
                SizedBox(height: 225.smh),
              ],
            ),
          ),
        ),
        _detailExpanded(),
      ],
    );
  }

  Widget _addressEquality() {
    return InkWell(
      onTap: () {
        ref.read(provider).deliveryTaxSame =
            !ref.read(provider).deliveryTaxSame;
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          ref.watch(provider).deliveryTaxSame
              ? CustomIcons.checkbox_checked_icon
              : CustomIcons.checkbox_unchecked_icon,
          SizedBox(width: 10.smw),
          CustomText(
            "Fatura ve teslimat adresi aynı",
            style: CustomFonts.bodyText3(CustomColors.backgroundText),
          ),
        ],
      ),
    );
  }

  Widget _deliveryAddress() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextLocale(LocaleKeys.BasketDetail_choice_address,
                  style: CustomFonts.bodyText2(CustomColors.backgroundText)),
              _editCard()
            ],
          ),
          SizedBox(height: 10.smh),
          ...ref
              .watch(provider)
              .addresses
              .map((e) => InkWell(
                    onTap: () {
                      ref.read(provider).selectedDeliveryAddress = e;
                    },
                    child: _radioContainer(
                        title: e.addressHeader,
                        description: e.address,
                        isSelected:
                            ref.watch(provider).selectedDeliveryAddress == e),
                  ))
              .toList(),
        ],
      ),
    );
  }

  Widget _taxAddress() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText("Fatura adresi seçin",
                  style: CustomFonts.bodyText2(CustomColors.backgroundText)),
            ],
          ),
          SizedBox(height: 10.smh),
          ...ref
              .watch(provider)
              .addresses
              .map((e) => InkWell(
                    onTap: () {
                      ref.read(provider).selectedTaxAddress = e;
                    },
                    child: _radioContainer(
                        title: e.addressHeader,
                        description: e.address,
                        isSelected:
                            ref.watch(provider).selectedTaxAddress == e),
                  ))
              .toList(),
        ],
      ),
    );
  }

  _deliveryTime() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextLocale(LocaleKeys.BasketDetail_choice_time,
                  style: CustomFonts.bodyText2(CustomColors.backgroundText)),
            ],
          ),
          SizedBox(height: 10.smh),
          _radioContainer(title: "Hemen teslim al", isSelected: true),
        ],
      ),
    );
  }

  _paymentType() {
    return SizedBox(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomTextLocale(LocaleKeys.BasketDetail_choice_payment_method,
                  style: CustomFonts.bodyText2(CustomColors.backgroundText)),
            ],
          ),
          SizedBox(height: 10.smh),
          _radioContainer(
              title: "Kapıda ödeme",
              isSelected: true,
              description: "Kapıda nakit veya pos cihazı ile ödeme"),
        ],
      ),
    );
  }

  Container _editCard() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.smw, vertical: 5.smh),
      decoration: BoxDecoration(
          borderRadius: CustomThemeData.fullInfiniteRounded,
          color: CustomColors.secondary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomIcons.edit_icon__small,
          SizedBox(width: 5.smw),
          CustomTextLocale(LocaleKeys.BasketDetail_edit,
              style: CustomFonts.bodyText5(CustomColors.secondaryText))
        ],
      ),
    );
  }

  Widget _detailExpanded() {
    return Positioned(
      bottom: 0.smh,
      child: Container(
        height: 200.smh,
        width: AppConstants.designWidth.smw,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: CustomColors.paymentCard,
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          boxShadow: [
            BoxShadow(
                color: const Color(0xFF50745C).withOpacity(0.5),
                blurRadius: 25,
                blurStyle: BlurStyle.inner)
          ],
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            InkWell(
              onTap: ref.read(provider).createOrder,
              child: Container(
                height: 50.smh,
                width: 300.smw,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    gradient: LinearGradient(
                      colors: CustomColors.paymentCard,
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    )),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomIcons.credit_card_icon_dark,
                    CustomTextLocale(LocaleKeys.Basket_continue_basket,
                        style: CustomFonts.bodyText2(CustomColors.cardText))
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.transparent,
              margin:
                  EdgeInsets.symmetric(horizontal: 25.smw, vertical: 10.smh),
              height: 80.smh,
              width: AppConstants.designWidth.smw,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(LocaleKeys.Basket_subtotal,
                          style: CustomFonts.bodyText4(CustomColors.cardText)),
                      CustomText(
                          ref
                              .watch(provider)
                              .basketTotal
                              .lineTotal
                              .toStringAsFixed(2),
                          style: CustomFonts.bodyText4(CustomColors.cardText))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(LocaleKeys.Basket_delivery_cost,
                          style: CustomFonts.bodyText4(CustomColors.cardText)),
                      CustomText(
                          ref
                              .watch(provider)
                              .basketTotal
                              .deliveryTotal
                              .toStringAsFixed(2),
                          style: CustomFonts.bodyText4(CustomColors.cardText))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomTextLocale(LocaleKeys.Basket_discount_cost,
                          style: CustomFonts.bodyText4(CustomColors.cardText)),
                      CustomText(
                          ref
                              .watch(provider)
                              .basketTotal
                              .promotionTotal
                              .toStringAsFixed(2),
                          style: CustomFonts.bodyText4(CustomColors.cardText))
                    ],
                  )
                ],
              ),
            ),
            Divider(thickness: 1.smh, height: 1.smh),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 25.smw),
                color: Colors.transparent,
                height: 49.smh,
                width: AppConstants.designWidth.smw,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomTextLocale(LocaleKeys.Basket_total,
                        style: CustomFonts.bodyText2(CustomColors.cardText)),
                    CustomText(
                        ref
                            .watch(provider)
                            .basketTotal
                            .lineTotal
                            .toStringAsFixed(2),
                        style: CustomFonts.bodyText4(CustomColors.cardText))
                  ],
                ))
          ],
        ),
      ),
    );
  }

  Widget _radioContainer(
      {required String title, String? description, required bool isSelected}) {
    return Container(
      constraints: BoxConstraints(minHeight: 60.smh),
      margin: EdgeInsets.only(bottom: 10.smh),
      decoration: BoxDecoration(
          color: CustomColors.primary, borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.smh),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: isSelected
                      ? CustomIcons.radio_checked_light_icon
                      : CustomIcons.radio_unchecked_light_icon,
                )),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomText(title,
                        style: CustomFonts.bodyText4(CustomColors.primaryText)),
                    description != null
                        ? CustomText(description,
                            style:
                                CustomFonts.bodyText5(CustomColors.primaryText),
                            maxLines: 2)
                        : const SizedBox()
                  ],
                )),
          ],
        ),
      ),
    );
  }

  // List<Widget> _optionsList() {
  //   List<Widget> options = [];
  //   options.add(_optionTile(title: "Zili Çalma", checked: true));
  //   options.add(SizedBox(height: 15.smh));
  //   options.add(_optionTile(
  //       title: "Temassız alışveriş",
  //       subtitle: "Ürünlerinizi kapınıza bırakıp sizi arıyacağız",
  //       checked: false));
  //   options.add(SizedBox(height: 15.smh));
  //   options.add(_optionTile(
  //       title: "Kullanım koşullarını okudum ve kabul ediyorum.",
  //       checked: true));

  //   return options;
  // }

  Widget _optionTile(
      {required String title, required bool checked, String? subtitle}) {
    return Container(
      constraints: BoxConstraints(minHeight: 50.smh),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            checked
                ? CustomIcons.checkbox_checked_icon
                : CustomIcons.checkbox_unchecked_icon,
            SizedBox(width: 10.smw),
            subtitle == null
                ? CustomText(title,
                    maxLines: 2,
                    style: CustomFonts.bodyText4(CustomColors.backgroundText))
                : Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title,
                          maxLines: 2,
                          style: CustomFonts.bodyText4(
                              CustomColors.backgroundText)),
                      CustomText(subtitle,
                          maxLines: 2,
                          style: CustomFonts.bodyText5(
                              CustomColors.backgroundTextPale))
                    ],
                  )
          ]),
    );
  }
}
