import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_icons.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class ProductDetailView extends ConsumerStatefulWidget {
  const ProductDetailView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductDetailViewState();
}

class _ProductDetailViewState extends ConsumerState<ProductDetailView> {
  List<String> imgUrls = [
    "https://picsum.photos/id/1/250/400",
    "https://picsum.photos/id/2/250/400",
    "https://picsum.photos/id/3/250/400",
    "https://picsum.photos/id/4/250/400",
    "https://picsum.photos/id/5/250/400",
    "https://picsum.photos/id/6/250/400"
  ];

  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  int index = 0;

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      backgroundColor: Colors.transparent,
      appBar: CustomAppBar.activeBack("Ürün Detay"),
      body: Stack(
        children: [
          Positioned(top: 0, child: _body()),
          Positioned(bottom: 0, child: _productBottomBar())
        ],
      ),
    ));
  }

  Column _body() {
    return Column(children: [
      SizedBox(height: 10.smh),
      Container(
          decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black))),
          child: _images()),
      SizedBox(
          height: 40.smh,
          width: 360.smw,
          child: Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: 20.smw, vertical: 30.smh),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Göral",
                        style: GoogleFonts.lexendDeca(
                            fontSize: 15.sp, color: Colors.grey)),
                    SizedBox(height: 0.smh),
                    Text("Gaziantep fıstığı",
                        style: GoogleFonts.lexendDeca(fontSize: 20.sp))
                  ])))
    ]);
  }

  Widget _images() {
    return SizedBox(
      height: 440.smh,
      width: AppConstants.designWidth.smw,
      child: Column(children: [
        SizedBox(
            width: AppConstants.designWidth.smw,
            height: 400.smh,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: _previousImage,
                    child: SizedBox(
                      height: 400.smh,
                      width: 55.smw,
                      child: const Center(child: Icon(Icons.arrow_back_ios)),
                    ),
                  ),
                  SizedBox(
                    height: 400.smh,
                    width: 250.smw,
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: imgUrls.length,
                      itemBuilder: (context, index) => Image.network(
                        imgUrls[index],
                        fit: BoxFit.cover,
                        height: 400.smh,
                        width: 250.smw,
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: _nextImage,
                    child: SizedBox(
                      height: 400.smh,
                      width: 55.smw,
                      child: const Center(child: Icon(Icons.arrow_forward_ios)),
                    ),
                  )
                ])),
        SizedBox(
          width: AppConstants.designWidth.smw,
          height: 40.smh,
          child: Center(
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      imgUrls.length,
                      (imgIndex) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 5.smw),
                          height: 10.smh,
                          width: 10.smh,
                          decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(5)),
                              color: imgIndex == index
                                  ? Colors.black
                                  : Colors.grey))))),
        )
      ]),
    );
  }

  void _previousImage() {
    setState(() {
      if (index > 0) {
        index--;
      }
    });
  }

  void _nextImage() {
    setState(() {
      if (index <= imgUrls.length - 1) {
        index++;
      }
    });
  }

  Widget _productBottomBar() {
    return SizedBox(
      width: AppConstants.designWidth.smw,
      height: 60.smh,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Container(
            color: CustomColors.primary,
            width: 150.smw,
            child: Center(
                child: Text(
              "155 TL",
              style: GoogleFonts.inder(fontSize: 20.sp, color: Colors.white),
            ))),
        InkWell(
          onTap: _addBasket,
          child: Container(
              color: CustomColors.secondary,
              width: 155.smw,
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomIcons.add_basket_icon,
                      Text("Sepete Ekle",
                          style:
                              CustomFonts.bodyText1(CustomColors.secondaryText))
                    ]),
              )),
        ),
        InkWell(
          onTap: _addFavorite,
          child: Container(
              color: CustomColors.primary,
              width: 55.smw,
              child: Center(
                  child: Container(
                width: 30.smh,
                height: 30.smh,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(50))),
                child: Center(
                  child: Icon(Icons.favorite,
                      size: 20.smh, color: CustomColors.primary),
                ),
              ))),
        ),
      ]),
    );
  }

  void _addFavorite() {}

  void _addBasket() {}
}
