import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/product_overview/product_overview_view.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  final ScrollController _scrollController = ScrollController();
  Map<String, GlobalKey> productKeys = {};

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafearea(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: const SearchBarView(hint: "Ürün veya kategori ara"),
              ),
              SizedBox(height: 10.h),
              _fastCategories(),
              SizedBox(height: 10.h),
              _imageBanner(),
              SizedBox(height: 10.h),
              _productBanner(),
              SizedBox(height: 85.h),
            ],
          ),
        ),
      ),
    );
  }

  Container _bannerBackground(Widget child, {required double height}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration:
          const BoxDecoration(gradient: CustomThemeData.bannerCardGradient),
      child: child,
    );
  }

  Widget _fastCategories() {
    return _bannerBackground(
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
          child: Scrollbar(
            trackVisibility: true,
            radius: const Radius.circular(45),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return SizedBox(
                    height: 60.h,
                    width: 60.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 10,
                                offset: Offset(0, 5.h),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              'https://picsum.photos/id/${index + 1}/60/60',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          "Category category $index",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inder(
                              fontWeight: FontWeight.w400, fontSize: 9.w),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(width: 10.w);
                }
              },
            ),
          ),
        ),
        height: 100.h);
  }

  _imageBanner() {
    return _bannerBackground(
        Padding(
          padding:
              EdgeInsets.only(bottom: 15.h, top: 5.h, left: 15.w, right: 15.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _allRow(),
              SizedBox(height: 5.h),
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
                                height: 170.h,
                                width: 330.w,
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
                      top: 15.h,
                      right: 15.w,
                      child: Container(
                        width: 40.w,
                        height: 20.h,
                        decoration: BoxDecoration(
                          color: CustomThemeData.bannerChipColor,
                          borderRadius: BorderRadius.circular(80),
                        ),
                        child: Center(
                          child: Text("2/16",
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
        ),
        height: 220.h);
  }

  _productBanner() {
    return _bannerBackground(
        Padding(
          padding:
              EdgeInsets.only(top: 5.h, left: 15.w, right: 15.w, bottom: 10.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _allRow(),
              SizedBox(height: 5.h),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    if (index % 2 == 0) {
                      productKeys["$index"] = GlobalKey();
                      return ProductOverviewView(key: productKeys["$index"]);
                    } else {
                      return SizedBox(width: 10.w);
                    }
                  },
                ),
              )
            ],
          ),
        ),
        height: 290.h);
  }

  Row _allRow() {
    return Row(
      // kampyanyalar ve tümü
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        const Text("Kampanyalar"),
        Container(
          height: 20.h,
          width: 90.w,
          padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 10.w),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(80),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("Tümü",
                  style: TextStyle(color: Colors.black, fontSize: 10.sp)),
              SvgPicture.asset(AssetConstants.arrow_rigth_circle,
                  color: Colors.green),
            ],
          ),
        )
      ],
    );
  }
}
