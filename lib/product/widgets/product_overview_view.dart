import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';

class ProductOverviewVerticalView extends ConsumerStatefulWidget {
  final ProductOverViewModel product;
  Function? onBasketChanged;
  ProductOverviewVerticalView({this.onBasketChanged, required this.product});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductOverviewViewVerticalState();
}

class _ProductOverviewViewVerticalState
    extends ConsumerState<ProductOverviewVerticalView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 250.smh, maxWidth: 160.smw),
      width: 160.smw,
      decoration: BoxDecoration(
          borderRadius: CustomThemeData.fullRounded, color: Colors.transparent),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 160.smh,
            child: Stack(
              children: [
                Positioned.fill(
                    child: ClipRRect(
                        borderRadius: CustomThemeData.topRounded,
                        child: widget.product
                            .image(height: 160.smh, width: 160.smw))),
                Positioned(
                    bottom: 5.smh,
                    left: 5.smw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [_unitCodeChip(), _favoriteChip()],
                    )),
                Positioned(
                  top: 10.smh,
                  right: 10.smw,
                  child: InkWell(
                    onTap: _favorite,
                    child: widget.product.isFavorite
                        ? CustomIcons.favorite_circle_icon
                        : CustomIcons.non_favorite_circle_icon,
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5.smw, vertical: 5.smh),
            color: CustomColors.cardInner,
            width: 160.smw,
            constraints: BoxConstraints(minHeight: 70.smh),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(widget.product.name,
                        maxLines: 2,
                        style:
                            CustomFonts.bodyText4(CustomColors.cardInnerText)),
                  ],
                ),
                SizedBox(height: 5.smh),
                CustomText(
                  "${widget.product.unitPrice.toStringAsFixed(2)} TL",
                  style: CustomFonts.bodyText2(CustomColors.cardInnerText),
                )
              ],
            ),
          ),
          Container(
            height: 40.smh,
            width: 160.smw,
            decoration: BoxDecoration(
              borderRadius: CustomThemeData.bottomRounded,
              color: CustomColors.secondary,
            ),
            child: widget.product.basketQuantity == null
                ? InkWell(
                    onTap: _addBasket,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CustomIcons.add_basket_outlined_icon,
                        CustomText(
                          LocaleKeys.Components_add_to_basket.tr(),
                          style:
                              CustomFonts.bodyText4(CustomColors.secondaryText),
                        )
                      ],
                    ))
                : _basketCount(),
          ),
        ],
      ),
    );
  }

  Widget _unitCodeChip() {
    return Container(
      margin: EdgeInsets.only(right: 5.smh),
      constraints: BoxConstraints(minWidth: 30.smw, minHeight: 15.smh),
      decoration: BoxDecoration(
          color: CustomColors.secondary,
          borderRadius: CustomThemeData.fullInfiniteRounded),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.smw),
        child: Center(
            child: CustomText(widget.product.unitCode,
                style: CustomFonts.bodyText5(CustomColors.secondaryText))),
      ),
    );
  }

  Widget _favoriteChip() {
    return Container(
      decoration: BoxDecoration(
          color: CustomColors.secondary,
          borderRadius: CustomThemeData.fullInfiniteRounded),
      constraints: BoxConstraints(minWidth: 30.smw, minHeight: 15.smh),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 5.smw),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.star, color: CustomColors.secondaryText, size: 10.smh),
              SizedBox(width: 5.smw),
              CustomText(widget.product.evaluationAvg.toStringAsFixed(1),
                  style: CustomFonts.bodyText5(CustomColors.secondaryText))
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _addBasket() async {
    setState(() {
      widget.product.basketQuantity ??= 0;
      widget.product.basketQuantity = widget.product.basketQuantity! + 1;
    });
    try {
      log(widget.product.basketQuantity.toString());
      ResponseModel response =
          await NetworkService.post("api/orders/addbasket", body: {
        "CariID": AuthService.currentUser!.id,
        "Barcode": widget.product.barcode,
        "Quantity": 1
      });

      if (response.success) {
        widget.onBasketChanged?.call();
      } else {
        setState(() {
          widget.product.basketQuantity = widget.product.basketQuantity! - 1;
          if (widget.product.basketQuantity == 0) {
            widget.product.basketQuantity = null;
          }
        });
        PopupHelper.showError(message: response.message);
      }
    } catch (e) {
      setState(() {
        widget.product.basketQuantity = widget.product.basketQuantity! - 1;
        if (widget.product.basketQuantity == 0) {
          widget.product.basketQuantity = null;
        }
      });
      PopupHelper.showError(message: "${LocaleKeys.ErrorCodes_ERROR}\n$e");
    }
  }

  Future<void> _removeBasket() async {
    setState(() {
      widget.product.basketQuantity = widget.product.basketQuantity! - 1;
      if (widget.product.basketQuantity! <= 0) {
        widget.product.basketQuantity = null;
      }
    });
    try {
      ResponseModel response =
          await NetworkService.post("api/orders/updatebasket", body: {
        "CariID": AuthService.currentUser!.id,
        "Barcode": widget.product.barcode,
        "Quantity": widget.product.basketQuantity ?? 0
      });
      if (response.success) {
        widget.onBasketChanged?.call();
      } else {
        setState(() {
          widget.product.basketQuantity =
              (widget.product.basketQuantity ?? 0) + 1;
        });
        PopupHelper.showError(message: response.message);
      }
    } catch (e) {
      setState(() {
        widget.product.basketQuantity =
            (widget.product.basketQuantity ?? 0) + 1;
      });
      PopupHelper.showError(message: "${LocaleKeys.ErrorCodes_ERROR}\n$e");
    }
  }

  Widget _basketCount() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
            child: InkWell(
                onTap: _removeBasket,
                child: Center(
                    child: CustomText("-",
                        style: CustomFonts.bodyText1(
                            CustomColors.secondaryText))))),
        Container(color: CustomColors.secondaryText, width: 1),
        Expanded(
          child: Center(
            child: CustomText(widget.product.basketQuantity.toString(),
                style: CustomFonts.bodyText3(CustomColors.secondaryText)),
          ),
        ),
        Container(color: CustomColors.secondaryText, width: 1),
        Expanded(
            child: InkWell(
                onTap: _addBasket,
                child: Center(
                    child: CustomText("+",
                        style: CustomFonts.bodyText1(
                            CustomColors.secondaryText))))),
      ],
    );
  }

  void _favorite() {
    setState(() {
      if (widget.product.isFavorite) {
        widget.product.favoriteId = 0;
      } else {
        widget.product.favoriteId = 1;
      }
    });
  }
}

class ProductOverViewHorizontal extends ConsumerWidget {
  final ProductOverViewModel product;
  const ProductOverViewHorizontal({Key? key, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      width: 320.smw,
      height: 90.smh,
      decoration: BoxDecoration(
        color: CustomColors.cardInner,
        border: Border.all(color: CustomColors.primary, width: 1),
        borderRadius: CustomThemeData.fullRounded,
      ),
      padding: EdgeInsets.symmetric(vertical: 5.smh, horizontal: 5.smw),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: CustomThemeData.fullRounded,
            child: product.image(height: 160.smh, width: 160.smh),
          ),
          SizedBox(width: 20.smw),
          Expanded(
            child: SizedBox(
              width: 180.smw,
              height: 80.smh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        product.tradeMark ?? "",
                        style: CustomFonts.bodyText3(CustomColors.primary),
                      ),
                      CustomText(
                        product.name + product.aciklama,
                        style: CustomFonts.bodyText4(
                            CustomColors.cardInnerTextPale),
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 5.smw),
                            decoration: BoxDecoration(
                                borderRadius:
                                    CustomThemeData.fullInfiniteRounded,
                                color: CustomColors.primary),
                            height: 15.smh,
                            child: Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.white,
                                  size: 10.smh,
                                ),
                                SizedBox(width: 2.smw),
                                CustomText(
                                  product.evaluationAvg.toStringAsFixed(1),
                                  style: CustomFonts.bodyText4(
                                      CustomColors.primaryText),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: 5.smw),
                          Container(
                            constraints: BoxConstraints(
                                minHeight: 15.smh, minWidth: 30.smw),
                            decoration: BoxDecoration(
                              color: CustomColors.primary,
                              borderRadius: CustomThemeData.fullInfiniteRounded,
                            ),
                            padding: EdgeInsets.symmetric(horizontal: 5.smw),
                            child: CustomText(product.unitCode,
                                style: CustomFonts.bodyText4(
                                    CustomColors.primaryText)),
                          )
                        ],
                      ),
                      CustomText(
                        "${product.unitPrice.toStringAsFixed(2)} TL",
                        style: CustomFonts.bodyText1(CustomColors.primary),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
