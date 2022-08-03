import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/cubits/home_cubit/home_index_cubit.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class BasketView extends ConsumerStatefulWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasketViewState();
}

class _BasketViewState extends ConsumerState<BasketView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafearea(
      child: Scaffold(
        body: _body(),
      ),
    );
  }

  Widget _body() {
    // if (false) {
    //   return _notEmpty();
    // } else {
    return _notEmpty();
    // }
  }

  Widget _notEmpty() {
    return Stack(
      children: [
        Positioned(
          left: 0,
          right: 0,
          bottom: 75.h,
          child: _detail(),
        )
      ],
    );
  }

  Widget _empty() {
    return Padding(
      padding:
          EdgeInsets.only(left: 14.w, right: 14.w, top: 185.h, bottom: 237.h),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AssetConstants.basket_empty,
                height: 170.h, width: 170.w),
            Text("Sepetiniz şuan boş!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 35.sp,
                  fontWeight: FontWeight.bold,
                )),
            InkWell(
              onTap: () {
                context.read<HomeIndexCubit>().set(2);
              },
              child: Container(
                width: 330.w,
                height: 70.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90),
                    color: Colors.green),
                child: Center(
                  child: Text("Hemen alışverişe başlayın",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20.sp,
                          color: const Color.fromRGBO(233, 254, 240, 1))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _detail() {
    return SizedBox(
      height: 125.h,
      child: Column(
        children: [
          Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              alignment: Alignment.center,
              height: 25.h,
              child: Text(
                  "32 ₺ tutarında alışveriş yaparsanız teslimat ücreti yok!",
                  style: TextStyle(fontSize: 12.sp))),
          Container(
            height: 100.h,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: CustomThemeData.scaffoldBackgroundGradinetColors,
            )),
            child: Column(
              children: [
                Container(
                  height: 59.5.h,
                  color: Colors.greenAccent,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Button 1"),
                      Text("Button 2"),
                    ],
                  ),
                ),
                Divider(thickness: 1.h, height: 1.h),
                Container(
                  height: 39.5.h,
                  color: Colors.greenAccent,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Toplam tutar"),
                        Text("32 ₺"),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
