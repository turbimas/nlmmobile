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
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/product/widgets/product_overview_view.dart';
import 'package:nlmmobile/view/main/search/search_view.dart';
import 'package:nlmmobile/view/main/search_result/search_resul_view_model.dart';
import 'package:nlmmobile/view/main/sub_categories/sub_categories_view.dart';

class SearchResultView extends ConsumerStatefulWidget {
  CategoryModel? categoryModel;
  List<CategoryModel>? masterCategories;
  String? searchText;
  List products;
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
              Row(
                children: [
                  Container(
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
                          style:
                              CustomFonts.bodyText2(CustomColors.secondaryText),
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 10.smw),
                  Container(
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
                          style:
                              CustomFonts.bodyText2(CustomColors.secondaryText),
                        )
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 10.smh),
              InkWell(
                onTap: () {
                  if (!widget.isSearch) {
                    NavigationService.back();
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
                        style:
                            CustomFonts.bodyText2(CustomColors.secondaryText),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
          SizedBox(width: 10.smw),
          InkWell(
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
          ),
        ],
      ),
    );
  }

  Widget _products() {
    return SingleChildScrollView(
      child: SizedBox(
        height: 610.smh,
        child: DynamicHeightGridView(
            shrinkWrap: true,
            mainAxisSpacing: 10.smh,
            crossAxisSpacing: 0.smw,
            builder: (context, index) => Center(
                  child: ProductOverviewVerticalView(
                      product: ref.watch(provider).products[index]),
                ),
            itemCount: ref.watch(provider).products.length,
            crossAxisCount: 2),
      ),
    );
  }
}
