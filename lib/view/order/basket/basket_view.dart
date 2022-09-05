import 'dart:developer';

import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_images.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_circular.dart';
import 'package:nlmmobile/product/widgets/custom_searchbar_view.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';
import 'package:nlmmobile/view/order/basket/basket_view_model.dart';
import 'package:nlmmobile/view/order/basket_detail/basket_detail_view.dart';

class BasketView extends ConsumerStatefulWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasketViewState();
}

class _BasketViewState extends ConsumerState<BasketView>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  bool isExpanded = true;
  double last = 10;

  late final ChangeNotifierProvider<BasketViewModel> provider;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, value: 1);
    _scrollController.addListener(() {
      log("scroll: ${_scrollController.offset}");
      if (_scrollController.offset < last) {
        _expand();
      } else {
        _nonExpand();
      }
      last = _scrollController.offset;
    });
    provider = ChangeNotifierProvider((ref) => BasketViewModel());
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(provider).getBasket();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
      appBar: CustomAppBar.inactiveBack(LocaleKeys.Basket_appbar_title.tr()),
    );
  }

  Widget _body() {
    return ref.watch(provider).retrieving ? _loading() : _content();
  }

  Widget _loading() {
    return const Center(child: CustomCircularProgressIndicator());
  }

  Widget _content() {
    return ref.watch(provider).products.isEmpty ? _empty() : _notEmpty();
  }

  Widget _notEmpty() {
    return Stack(
      children: [
        Positioned(
          top: 10.smh,
          left: 15.smw,
          right: 15.smw,
          bottom: 75.smh,
          child: Column(children: [
            CustomSearchBarView(hint: LocaleKeys.Basket_search_hint.tr()),
            SizedBox(height: 10.smh),
            SizedBox(
              height: 600.smh,
              child: DynamicHeightGridView(
                  controller: _scrollController,
                  shrinkWrap: true,
                  mainAxisSpacing: 10.smh,
                  crossAxisSpacing: 10.smw,
                  builder: (context, index) =>
                      index >= ref.watch(provider).products.length
                          ? const Card()
                          : Center(
                              child: ProductOverviewVerticalView(
                                product: ref.watch(provider).products[index],
                                onBasketChanged: ref.read(provider).getBasket,
                              ),
                            ),
                  itemCount: ref.watch(provider).products.length + 2,
                  crossAxisCount: 2),
            ),
          ]),
        ),
        _detailExpanded()
      ],
    );
  }

  Widget _empty() {
    return Center(
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.smh),
            CustomImages.basket_empty,
            SizedBox(height: 40.smh),
            Text(LocaleKeys.BasketEmpty_basket_empty.tr(),
                style: CustomFonts.bodyText1(CustomColors.backgroundText)
                    .copyWith(fontSize: 30.sp)),
            SizedBox(height: 40.smh),
            InkWell(
              onTap: () => context.read<HomeIndexCubit>().set(2),
              child: Container(
                decoration: BoxDecoration(
                    color: CustomColors.secondary,
                    borderRadius: CustomThemeData.fullRounded),
                constraints:
                    BoxConstraints(maxWidth: 330.smw, minHeight: 70.smh),
                child: Center(
                    child: Text(
                  LocaleKeys.BasketEmpty_shop_now.tr(),
                  style: CustomFonts.bigButton(CustomColors.secondaryText),
                )),
              ),
            ),
          ]),
    );
  }

  Widget _detailExpanded() {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, child) => Positioned(
        bottom: (25 - 250 + _animationController.value * 250).smh,
        child: Container(
          color: Colors.transparent,
          height: 250.smh,
          width: AppConstants.designWidth.smw,
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
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const BasketDetailView()));
                  },
                  child: Container(
                    // ödemeye git
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
                      children: const [
                        // SvgPicture.asset(AssetEnums.payment_card.svg,
                        //     height: 22.smh, width: 32.smw),
                        Text("Sepete devam et")
                      ],
                    ),
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  margin: EdgeInsets.symmetric(
                      horizontal: 25.smw, vertical: 10.smh),
                  height: 80.smh,
                  width: AppConstants.designWidth.smw,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Ara toplam",
                              style: TextStyle(color: CustomColors.cardText)),
                          const Text("23,65 TL")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Teslimat Tutarı",
                              style: TextStyle(color: CustomColors.cardText)),
                          const Text("53.23 TL")
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("İndirim tutarı",
                              style: TextStyle(color: CustomColors.cardText)),
                          const Text("76.42 TL")
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
                      Text("TOPLAM TUTAR",
                          style: GoogleFonts.leagueSpartan(
                              color: CustomColors.cardText, fontSize: 18.sp)),
                      const Text("1652.42 TL")
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _expand() {
    if (isExpanded) {
      _animationController.animateTo(1,
          duration: const Duration(milliseconds: 800),
          curve: Curves.linearToEaseOut);
      isExpanded = false;
    }
  }

  void _nonExpand() {
    if (!isExpanded) {
      _animationController.animateTo(0,
          duration: const Duration(milliseconds: 800),
          curve: Curves.linearToEaseOut);
      isExpanded = true;
    }
  }
}
