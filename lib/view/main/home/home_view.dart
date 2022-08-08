import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/product_overview/product_overview_view.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
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
            child: const SearchBarView(hint: "Ürün veya kategori ara"),
          ),
          _fastCategories(),
          SizedBox(height: 15.smh),
          _imageBanner(),
          SizedBox(height: 15.smh),
          _productBanner(),
          SizedBox(height: 75.smh),
        ],
      ),
    );
  }

  Container _bannerBackground({required Widget child, required double height}) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: CustomThemeData.bannerCardGradientColors)),
      child: child,
    );
  }

  Widget _fastCategories() {
    return _bannerBackground(
        height: 100.smh,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.smw, vertical: 5.smh),
          child: Scrollbar(
            trackVisibility: true,
            radius: const Radius.circular(45),
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: (context, index) {
                if (index % 2 == 0) {
                  return SizedBox(
                    height: 60.smh,
                    width: 60.smw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.25),
                                blurRadius: 10,
                                offset: Offset(0, 5.smh),
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
                        SizedBox(height: 5.smh),
                        Text(
                          "Category category $index",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inder(
                              fontWeight: FontWeight.w400, fontSize: 9.smw),
                        ),
                      ],
                    ),
                  );
                } else {
                  return SizedBox(width: 10.smw);
                }
              },
            ),
          ),
        ));
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
                      return const ProductOverviewView();
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
      // kampyanyalar ve tümü
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
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
