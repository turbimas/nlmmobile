import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:nlmmobile/core/services/theme/custom_colors.dart';
import 'package:nlmmobile/core/services/theme/custom_fonts.dart';
import 'package:nlmmobile/core/utils/extensions/ui_extensions.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/custom_text.dart';

class DeliveryTimeView extends ConsumerStatefulWidget {
  const DeliveryTimeView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _DeliveryTimeViewState();
}

class _DeliveryTimeViewState extends ConsumerState<DeliveryTimeView> {
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
        color: isSelected ? CustomColors.primary : CustomColors.secondary,
        borderRadius: const BorderRadius.only(
            topRight: Radius.circular(30), bottomRight: Radius.circular(30)),
      ),
      child: Align(
        alignment: Alignment.centerLeft,
        child: CustomText(time,
            style: CustomFonts.bodyText3(CustomColors.secondaryText)),
      ),
    );
  }
}
