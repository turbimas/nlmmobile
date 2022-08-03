import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/product_overview/product_overview_view.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafearea(
      child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(height: 20.h),
                const SearchBarView(hint: "Favorilerde ara"),
                SizedBox(height: 10.h),
                Expanded(
                  child: GridView.custom(
                    shrinkWrap: true,
                    childrenDelegate: SliverChildBuilderDelegate(
                        (context, index) => const ProductOverviewView()),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        mainAxisExtent: 250.h,
                        crossAxisCount: 2,
                        mainAxisSpacing: 20.h,
                        crossAxisSpacing: 20.w),
                  ),
                ),
                // SizedBox(height: 85. h),
              ],
            ),
          )),
    );
  }
}
