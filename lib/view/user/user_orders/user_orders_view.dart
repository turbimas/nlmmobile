import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class UserOrdersView extends ConsumerStatefulWidget {
  const UserOrdersView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserOrdersViewState();
}

class _UserOrdersViewState extends ConsumerState<UserOrdersView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        appBar: CustomAppBar.activeBack("Siparişlerim"),
        body: Column(
          children: [
            SizedBox(height: 10.smh),
            Container(
              padding: EdgeInsets.only(
                  top: 8.smh, bottom: 7.smh, left: 10.smw, right: 10.smw),
              width: AppConstants.designWidth.smw,
              color: CustomThemeData.primaryColor,
              height: 60.smh,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    _statusChip(title: "Hazırlanıyor", isSelected: true),
                    _statusChip(title: "Tamamlandı", isSelected: true),
                    _statusChip(title: "İptal Edildi", isSelected: false)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _statusChip({required String title, required bool isSelected}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.smw),
      padding: EdgeInsets.symmetric(horizontal: 10.smw),
      height: 45.smh,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      child: Center(
          child: Text(
        title,
        style: TextStyle(fontSize: 20.sp),
      )),
    );
  }
}
