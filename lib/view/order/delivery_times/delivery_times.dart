import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class DeliveryTimesView extends ConsumerStatefulWidget {
  const DeliveryTimesView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryTimesViewState();
}

class _DeliveryTimesViewState extends ConsumerState<DeliveryTimesView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar: CustomAppBar.activeBack("Teslimat Süresi seçin"),
      body: Padding(
        padding: EdgeInsets.only(left: 0, right: 30.smw, top: 10.smh),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _timeTile(time: "15:00 - 16:00", isSelected: false),
            _timeTile(time: "15:00 - 16:00", isSelected: false),
            _timeTile(time: "15:00 - 16:00", isSelected: true),
            _timeTile(time: "15:00 - 16:00", isSelected: false),
            _timeTile(time: "15:00 - 16:00", isSelected: false),
            _timeTile(time: "15:00 - 16:00", isSelected: false),
            _timeTile(time: "15:00 - 16:00", isSelected: false),
            _timeTile(time: "15:00 - 16:00", isSelected: false),
          ],
        ),
      ),
    ));
  }

  _timeTile({required String time, required bool isSelected}) {
    return Container(
      height: 45.smh,
      width: 350.smw,
      margin: EdgeInsets.only(bottom: 5.smh),
      padding: EdgeInsets.only(left: 20.smh),
      decoration: BoxDecoration(
        color: isSelected
            ? CustomThemeData.primaryColor
            : CustomThemeData.secondaryColor,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(time,
            style: GoogleFonts.inder(fontSize: 14.sp, color: Colors.white)),
      ),
    );
  }
}
