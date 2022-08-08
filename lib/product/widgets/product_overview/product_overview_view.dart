import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/view/product/product_detail/product_detail_view.dart';

class ProductOverviewView extends ConsumerStatefulWidget {
  const ProductOverviewView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ProductOverviewViewState();
}

class _ProductOverviewViewState extends ConsumerState<ProductOverviewView> {
  final String imageUrl =
      'https://images.unsplash.com/photo-1518791841217-8f162f1e1131?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60';
  final String title = 'Product Title';
  final String description = 'Product Description';
  final String price = '\$100';
  final String rating = '4.5';
  final String unitType = 'KG';
  final String color = 'Red';
  final String quantity = '1';

  int count = 0;
  bool get isEmpty => count == 0;
  bool get isOneAdded => count == 1;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const ProductDetailView()));
      },
      child: Container(
        height: 250.smh,
        width: 160.smw,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
                // image box
                height: 140.smh,
                width: 160.smw,
                child: Stack(
                  children: [
                    Positioned.fill(
                        child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            ),
                            child: Image.network(imageUrl, fit: BoxFit.cover))),
                    Positioned(
                        top: 10.smh,
                        right: 10.smw,
                        child: Container(
                          height: 30.sp,
                          width: 30.sp,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: Colors.green,
                              width: 1,
                            ),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.green.withOpacity(0.3),
                                blurRadius: 10,
                                spreadRadius: 5,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.favorite,
                            color: Colors.green,
                            size: 20.sp,
                          ),
                        ))
                  ],
                )),
            Container(
              width: 160.smw,
              height: 70.smh,
              padding:
                  EdgeInsets.symmetric(horizontal: 10.smw, vertical: 5.smh),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Göral",
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.inder(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0Xff646363))),
                  Text("Gaziantep fıstığı",
                      overflow: TextOverflow.fade,
                      style: GoogleFonts.inder(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff1a1a1a))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: const [
                      // _weigthChip(),
                      //  _starChip(),
                      //   _favoriteChip()
                    ],
                  )
                ],
              ),
            ),
            Container(
              height: 40.smh,
              width: 160.smw,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                color: CustomThemeData.secondaryColor,
              ),
              padding:
                  EdgeInsets.symmetric(horizontal: 10.smw, vertical: 5.smh),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("100 TL",
                      style: GoogleFonts.inder()
                          .copyWith(fontSize: 16.sp, color: Colors.white)),
                  SvgPicture.asset(AssetConstants.shopping_card_plus,
                      color: Colors.white, height: 20.smh, width: 20.smw),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  // _weigthChip() {
  //   return Container(
  //       padding: EdgeInsets.symmetric(
  //         horizontal: 5.smw,
  //         vertical: 5.smh,
  //       ),
  //       height: 15.smh,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(5),
  //         color: CustomThemeData.primaryColor,
  //         boxShadow: [
  //           BoxShadow(
  //             color: Colors.green.withOpacity(0.3),
  //             blurRadius: 10,
  //             spreadRadius: 5,
  //             offset: const Offset(0, 5),
  //           ),
  //         ],
  //       ),
  //       child: Row(
  //         children: [
  //           SvgPicture.asset(AssetConstants.scale,
  //               color: Colors.white, height: 16.smh, width: 16.smh),
  //           SizedBox(width: 2.smw),
  //           const Text("1 KG")
  //         ],
  //       ));
  // }

  _starChip() {
    return const Chip(label: Text("1.5KG"));
  }

  _favoriteChip() {
    return const Chip(label: Text("1.5KG"));
  }
}
