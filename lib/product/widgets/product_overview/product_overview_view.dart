import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/custom_icons_icons.dart';

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
    return Container(
      height: 250.h,
      width: 160.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
              // image box
              height: 140.h,
              width: 160.w,
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
                      top: 10.h,
                      right: 10.w,
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
            width: 160.w,
            height: 70.h,
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Göral",
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.inder(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0Xff646363))),
                Text("Gaziantep fıstığı",
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.inder(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xff1a1a1a))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    _weigthChip(),
                    //  _starChip(),
                    //   _favoriteChip()
                  ],
                )
              ],
            ),
          ),
          Container(
            height: 40.h,
            width: 160.w,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              color: Colors.green,
            ),
            padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("100 TL",
                    style: GoogleFonts.inder()
                        .copyWith(fontSize: 16, color: Colors.white)),
                const Icon(CustomIcons.cart_plus)
              ],
            ),
          )
        ],
      ),
    );
  }

  _weigthChip() {
    return Container(
        padding: EdgeInsets.symmetric(
          horizontal: 5.w,
          vertical: 5.h,
        ),
        height: 15.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.green,
          boxShadow: [
            BoxShadow(
              color: Colors.green.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 5,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(Icons.scale, size: 8.h),
            SizedBox(width: 2.w),
            const Text("1 KG")
          ],
        ));
  }

  _starChip() {
    return const Chip(label: Text("1.5KG"));
  }

  _favoriteChip() {
    return const Chip(label: Text("1.5KG"));
  }
}
