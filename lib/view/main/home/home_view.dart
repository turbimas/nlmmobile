import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/navigation/navigation_service.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/models/category_model.dart';
import 'package:nlmmobile/product/widgets/custom_circular.dart';
import 'package:nlmmobile/product/widgets/custom_searchbar_view.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';
import 'package:nlmmobile/view/main/home/home_view_model.dart';
import 'package:nlmmobile/view/main/search/search_view.dart';
import 'package:nlmmobile/view/main/sub_categories/sub_categories_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  late final ChangeNotifierProvider<HomeViewModel> provider;

  @override
  void initState() {
    provider = ChangeNotifierProvider((ref) => HomeViewModel());
    super.initState();
    Future.delayed(Duration.zero, () {
      ref.read(provider).getCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: 15.smw, right: 15.smw, top: 10.smh, bottom: 15.smh),
            child: InkWell(
                onTap: () {
                  NavigationService.navigateToPage(const SearchView());
                },
                child: AbsorbPointer(
                    child: CustomSearchBarView(
                        hint: LocaleKeys.Home_search_hint.tr()))),
          ),
          _fastCategories(),
          SizedBox(height: 15.smh),
          // _imageBanner(),
          // SizedBox(height: 15.smh),
          // _productBanner(),
          // SizedBox(height: 75.smh),
        ],
      ),
    );
  }

  Container _bannerBackground({required Widget child, double? height}) {
    return Container(
      height: height,
      width: double.infinity,
      color: CustomColors.card,
      child: child,
    );
  }

  Widget _fastCategories() {
    return Container(
      height: 120.smh,
      color: CustomColors.card,
      width: AppConstants.designWidth.smw,
      padding: EdgeInsets.symmetric(vertical: 5.smh),
      child: ref.watch(provider).categoriesLoading
          ? const Center(child: CustomCircularProgressIndicator())
          : Scrollbar(
              trackVisibility: true,
              radius: CustomThemeData.fullInfiniteRounded.topLeft,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: ref.watch(provider).categories.length,
                  itemBuilder: (context, index) {
                    CategoryModel category =
                        ref.watch(provider).categories[index];
                    return InkWell(
                      onTap: () => NavigationService.navigateToPage(
                          SubCategoriesView(
                              masterCategory: category,
                              masterCategories:
                                  ref.watch(provider).categories)),
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 10.smw,
                            right: index ==
                                    ref.watch(provider).categories.length - 1
                                ? 0
                                : 10.smw),
                        width: 60.smw,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  boxShadow: CustomThemeData.shadow2),
                              child: ClipRRect(
                                  borderRadius: CustomThemeData.fullRounded,
                                  child: category.image(
                                      height: 60.h, width: 60.h)),
                            ),
                            SizedBox(height: 5.smh),
                            Expanded(
                              child: SizedBox(
                                width: 60.smw,
                                child: CustomText(
                                  category.groupName,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: CustomFonts.bodyText4(
                                      CustomColors.cardText),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
    );
  }

  _imageBanner() {
    return _bannerBackground(
        height: 220.smh,
        child: Padding(
          padding: EdgeInsets.only(
              bottom: 15.smh, top: 5.smh, left: 15.smw, right: 15.smw),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.smw),
                  child: _allRow("Kampanyalar")),
              SizedBox(height: 5.smh),
              Expanded(
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: PageView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 20,
                          itemBuilder: (context, index) {
                            return SizedBox(
                                height: 170.smh,
                                width: 330.smw,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.network(
                                    'https://picsum.photos/id/${index + 1}/330/170',
                                    fit: BoxFit.cover,
                                  ),
                                ));
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 15.smh,
                      right: 15.smw,
                      child: Container(
                        width: 40.smw,
                        height: 20.smh,
                        decoration: BoxDecoration(
                          color: CustomColors.card,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Center(
                          child: CustomText("2/16",
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 10.sp)),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  _productBanner() {
    return _bannerBackground(
        height: 305.smh,
        child: Padding(
          padding: EdgeInsets.only(
              top: 5.smh, left: 15.smw, right: 15.smw, bottom: 25.smh),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15.smw),
                  child: _allRow("En çok satılanlar")),
              SizedBox(height: 5.smh),
              SizedBox(
                width: 330.smw,
                height: 250.smh,
                child: ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      return const Card();
                      // return const ProductOverviewVerticalView();
                    } else {
                      return SizedBox(width: 10.smw);
                    }
                  },
                ),
              ),
            ],
          ),
        ));
  }

  Row _allRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CustomText(title),
        Container(
          height: 20.smh,
          width: 90.smw,
          padding: EdgeInsets.symmetric(vertical: 2.5.smh, horizontal: 10.smw),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(80),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CustomTextLocale(LocaleKeys.Home_all,
                  style: TextStyle(color: Colors.black, fontSize: 12.sp)),
              CustomIcons.arrow_right_circle_icon
            ],
          ),
        )
      ],
    );
  }
}
