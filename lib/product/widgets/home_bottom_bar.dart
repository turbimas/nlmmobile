import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fluttericon/elusive_icons.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/custom_icons_icons.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';

class HomeBottomBar extends StatelessWidget {
  static const double iconSize = 25;
  static const int iconCount = 5;
  static const double startPixel = 30;
  static const Color iconColor = CustomThemeData.bottomBarIconColor;

  static const _animationDuration = Duration(milliseconds: 100);

  @override
  Widget build(BuildContext context) {
    final screenWidth = ScreenUtil.defaultSize.width;

    double gapPixel =
        ((screenWidth - (2 * startPixel) - (iconCount * iconSize)) /
                (iconCount - 1)) -
            startPixel / iconCount;

    return Theme(
      data: ThemeData(
          iconTheme: const IconThemeData(
        color: Colors.white,
        size: iconSize,
      )),
      child: Container(
          color: Colors.transparent,
          width: ScreenUtil.defaultSize.width.smw,
          height: 100.smh,
          child: Stack(
            children: [
              Positioned(
                // Container
                bottom: 0,
                child: Container(
                  color: CustomThemeData.bottomBarBackgroundColor,
                  height: 75.smh,
                  width: ScreenUtil.defaultSize.width.w,
                ),
              ),
              _iconContainer(
                  context,
                  0,
                  startPixel + (gapPixel * 0) + (iconSize * 0),
                  const Icon(CustomIcons.search,
                      size: iconSize, color: iconColor)),
              _iconContainer(
                  context,
                  1,
                  startPixel + (gapPixel * 1) + (iconSize * 1),
                  const Icon(
                    Icons.favorite,
                    color: iconColor,
                  )),
              _iconContainer(
                  context,
                  2,
                  startPixel + (gapPixel * 2) + (iconSize * 2),
                  SvgPicture.asset(AssetConstants.home_menu,
                      height: 25.smh, width: 25.smh)),
              _iconContainer(
                  context,
                  3,
                  startPixel + (gapPixel * 3) + (iconSize * 3),
                  const Icon(Elusive.basket, color: iconColor)),
              _iconContainer(
                  context,
                  4,
                  startPixel + (gapPixel * 4) + (iconSize * 4),
                  const Icon(Icons.person, color: iconColor)),
            ],
          )),
    );
  }

  _iconContainer(
          BuildContext context, int index, double location, Widget icon) =>
      AnimatedPositioned(
        duration: _animationDuration,
        bottom: context.watch<HomeIndexCubit>().state.sayac == index
            ? 50.smh
            : 15.smh,
        left: location.w,
        child: InkWell(
          onTap: () {
            context.read<HomeIndexCubit>().set(index);
          },
          child: AnimatedContainer(
              duration: _animationDuration,
              width: 50.smh,
              height: 50.smh,
              decoration: BoxDecoration(
                color: context.watch<HomeIndexCubit>().state.sayac == index
                    ? CustomThemeData.bottomBarHighlightColor
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: icon)),
        ),
      );
}
