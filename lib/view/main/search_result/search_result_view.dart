import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/models/category_model.dart';
import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/ok_cancel_prompt.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';
import 'package:nlmmobile/view/main/search/search_view.dart';
import 'package:nlmmobile/view/main/search_result/search_result_view_model.dart';
import 'package:nlmmobile/view/main/sub_categories/sub_categories_view.dart';

class SearchResultView extends ConsumerStatefulWidget {
  CategoryModel? categoryModel;
  List<CategoryModel>? masterCategories;
  String? searchText;
  List<ProductOverViewModel> products;
  bool isSearch;
  SearchResultView(
      {Key? key,
      this.categoryModel,
      this.masterCategories,
      this.searchText,
      required this.isSearch,
      required this.products})
      : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _SearchResultViewState();
}

class _SearchResultViewState extends ConsumerState<SearchResultView> {
  late final ChangeNotifierProvider<SearchResultViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => SearchResultViewModel(
        products: widget.products,
        categoryModel: widget.categoryModel,
        searchText: widget.searchText));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar:
          CustomAppBar.activeBack(LocaleKeys.SearchResult_appbar_title.tr()),
      body: Column(
        children: [_actions(), _products()],
      ),
    ));
  }

  Widget _actions() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.smh, horizontal: 15.smw),
      child: Row(
        children: [
          Column(
            children: [
              AbsorbPointer(
                absorbing: ref.watch(provider).products.isEmpty,
                child: Row(
                  children: [_order(), SizedBox(width: 10.smw), _filter()],
                ),
              ),
              SizedBox(height: 10.smh),
              _categories()
            ],
          ),
          SizedBox(width: 10.smw),
          _search(),
        ],
      ),
    );
  }

  InkWell _search() {
    return InkWell(
      onTap: () {
        if (widget.isSearch) {
          NavigationService.back();
        } else {
          NavigationService.navigateToPage(const SearchView());
        }
      },
      child: Container(
        height: 110.smh,
        width: 60.smw,
        decoration: BoxDecoration(
            color: CustomColors.secondary,
            borderRadius: CustomThemeData.fullRounded),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIcons.search_icon,
            CustomTextLocale(
              LocaleKeys.SearchResult_search,
              maxLines: 1,
              style: CustomFonts.bodyText2(CustomColors.secondaryText),
            )
          ],
        ),
      ),
    );
  }

  InkWell _categories() {
    return InkWell(
      onTap: () {
        if (widget.categoryModel != null) {
          NavigationService.navigateToPage(SubCategoriesView(
            masterCategory: widget.categoryModel,
            masterCategories: widget.masterCategories,
          ));
        } else {
          NavigationService.navigateToPage(SubCategoriesView());
        }
      },
      child: Container(
        width: 260.smw,
        height: 50.smh,
        decoration: BoxDecoration(
            color: CustomColors.secondary,
            borderRadius: CustomThemeData.fullRounded),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIcons.categories_icon,
            CustomTextLocale(
              LocaleKeys.SearchResult_change_category,
              maxLines: 1,
              style: CustomFonts.bodyText2(CustomColors.secondaryText),
            )
          ],
        ),
      ),
    );
  }

  Widget _filter() {
    return InkWell(
      onTap: _showFilterPopup,
      child: Container(
        width: 125.smw,
        height: 50.smh,
        decoration: BoxDecoration(
            color: CustomColors.secondary,
            borderRadius: CustomThemeData.fullRounded),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIcons.filter_icon,
            CustomTextLocale(
              LocaleKeys.SearchResult_filter,
              maxLines: 1,
              style: CustomFonts.bodyText2(CustomColors.secondaryText),
            )
          ],
        ),
      ),
    );
  }

  Widget _order() {
    return InkWell(
      onTap: _showOrderPopup,
      child: Container(
        width: 125.smw,
        height: 50.smh,
        decoration: BoxDecoration(
            color: CustomColors.secondary,
            borderRadius: CustomThemeData.fullRounded),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            CustomIcons.order_icon,
            CustomTextLocale(
              LocaleKeys.SearchResult_order,
              maxLines: 1,
              style: CustomFonts.bodyText2(CustomColors.secondaryText),
            )
          ],
        ),
      ),
    );
  }

  Widget _products() {
    if (ref.watch(provider).filteredProducts.isEmpty) {
      return SizedBox(
        height: 610.smh,
        child: Center(
            child: CustomText("Aradığınız kriterlere uygun sonuç bulunamadı",
                maxLines: 2,
                style: CustomFonts.bodyText2(CustomColors.backgroundText))),
      );
    } else {
      return SingleChildScrollView(
        child: SizedBox(
          height: 610.smh,
          child: DynamicHeightGridView(
              shrinkWrap: true,
              mainAxisSpacing: 10.smh,
              crossAxisSpacing: 0.smw,
              builder: (context, index) => Center(
                    child: ProductOverviewVerticalView(
                        product: ref.watch(provider).filteredProducts[index]),
                  ),
              itemCount: ref.watch(provider).filteredProducts.length,
              crossAxisCount: 2),
        ),
      );
    }
  }

  void _showFilterPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer(builder: (context, ref, child) {
            return Dialog(
              insetPadding: EdgeInsets.symmetric(horizontal: 0.smw),
              backgroundColor: Colors.transparent,
              child: Container(
                width: 330.smw,
                height: 500.smh,
                decoration: BoxDecoration(
                    borderRadius: CustomThemeData.fullRounded,
                    color: CustomColors.primary),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 10.smh),
                      padding: EdgeInsets.symmetric(horizontal: 30.smw),
                      child: Align(
                          alignment: Alignment.centerLeft,
                          child: CustomText(
                            "Filitreleme",
                            style:
                                CustomFonts.bodyText1(CustomColors.primaryText),
                          )),
                    )
                  ],
                ),
              ),
            );
          });
        });
  }

  void _showOrderPopup() {
    showDialog(
        context: context,
        builder: (context) {
          return Consumer(
            builder: (context, ref, child) {
              return Dialog(
                insetPadding: EdgeInsets.symmetric(horizontal: 0.smw),
                backgroundColor: Colors.transparent,
                child: Container(
                  width: 330.smw,
                  height: 500.smh,
                  decoration: BoxDecoration(
                      borderRadius: CustomThemeData.fullRounded,
                      color: CustomColors.primary),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.symmetric(vertical: 10.smh),
                            padding: EdgeInsets.symmetric(horizontal: 30.smw),
                            child: Align(
                                alignment: Alignment.centerLeft,
                                child: CustomText(
                                  "Sıralama",
                                  style: CustomFonts.bodyText1(
                                      CustomColors.primaryText),
                                )),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(provider).orderPrice = true;
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.smh),
                                width: 300,
                                decoration: BoxDecoration(
                                    color: CustomColors.secondary,
                                    borderRadius:
                                        CustomThemeData.fullInfiniteRounded),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: ref
                                                          .watch(provider)
                                                          .orderPrice ==
                                                      true
                                                  ? CustomIcons
                                                      .radio_checked_light_icon
                                                  : CustomIcons
                                                      .radio_unchecked_light_icon)),
                                      Expanded(
                                          flex: 5,
                                          child: CustomText(
                                            "Fiyat (Küçükten büyüğe)",
                                            style: CustomFonts.bodyText4(
                                                CustomColors.secondaryText),
                                          ))
                                    ])),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(provider).orderPrice = false;
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.smh),
                                width: 300,
                                decoration: BoxDecoration(
                                    color: CustomColors.secondary,
                                    borderRadius:
                                        CustomThemeData.fullInfiniteRounded),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: ref
                                                          .watch(provider)
                                                          .orderPrice ==
                                                      false
                                                  ? CustomIcons
                                                      .radio_checked_light_icon
                                                  : CustomIcons
                                                      .radio_unchecked_light_icon)),
                                      Expanded(
                                          flex: 5,
                                          child: CustomText(
                                            "Fiyat (Büyükten küçüğe)",
                                            style: CustomFonts.bodyText4(
                                                CustomColors.secondaryText),
                                          ))
                                    ])),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(provider).orderName = true;
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.smh),
                                width: 300,
                                decoration: BoxDecoration(
                                    color: CustomColors.secondary,
                                    borderRadius:
                                        CustomThemeData.fullInfiniteRounded),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: ref
                                                          .watch(provider)
                                                          .orderName ==
                                                      true
                                                  ? CustomIcons
                                                      .radio_checked_light_icon
                                                  : CustomIcons
                                                      .radio_unchecked_light_icon)),
                                      Expanded(
                                          flex: 5,
                                          child: CustomText(
                                            "İsim (A-Z)",
                                            style: CustomFonts.bodyText4(
                                                CustomColors.secondaryText),
                                          ))
                                    ])),
                          ),
                          InkWell(
                            onTap: () {
                              ref.read(provider).orderName = false;
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(vertical: 10.smh),
                                width: 300,
                                decoration: BoxDecoration(
                                    color: CustomColors.secondary,
                                    borderRadius:
                                        CustomThemeData.fullInfiniteRounded),
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Expanded(
                                          flex: 1,
                                          child: Center(
                                              child: ref
                                                          .watch(provider)
                                                          .orderName ==
                                                      false
                                                  ? CustomIcons
                                                      .radio_checked_light_icon
                                                  : CustomIcons
                                                      .radio_unchecked_light_icon)),
                                      Expanded(
                                          flex: 5,
                                          child: CustomText(
                                            "İsim (Z-A)",
                                            style: CustomFonts.bodyText4(
                                                CustomColors.secondaryText),
                                          ))
                                    ])),
                          ),
                        ],
                      ),
                      OkCancelPrompt.forPopup(
                          okCallBack: ref.read(provider).order,
                          cancelCallBack: () {
                            NavigationService.back();
                          }),
                    ],
                  ),
                ),
              );
            },
          );
        });
  }
}
