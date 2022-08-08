import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class OrderSuccessView extends ConsumerStatefulWidget {
  const OrderSuccessView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _OrderSuccessViewState();
}

class _OrderSuccessViewState extends ConsumerState<OrderSuccessView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 320.smh,
              width: 250.smw,
              child: SvgPicture.asset(AssetConstants.basket_done,
                  height: 320.smh, width: 250.smw),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              Container(
                  height: 40.smh,
                  width: 60.smw,
                  decoration: BoxDecoration(
                      color: CustomThemeData.secondaryColor,
                      borderRadius: BorderRadius.circular(5)),
                  child: Center(
                      child: Icon(Icons.check,
                          color: Colors.white, size: 20.smh))),
              Text("Siparişinizi aldık",
                  style: GoogleFonts.mina(fontSize: 22.sp)),
            ]),
            SizedBox(height: 40.smh),
            SizedBox(
              width: 320.smw,
              height: 50.smh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Sipariş numaranız: 1231231",
                      style: GoogleFonts.mina(fontSize: 22.sp)),
                  SizedBox(width: 20.smw),
                  const Icon(Icons.copy)
                ],
              ),
            ),
            SizedBox(height: 10.smh),
            Container(
              height: 80.smh,
              width: 290.smw,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  color: CustomThemeData.secondaryColor),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      height: 80.smh,
                      width: 225.smw,
                      child: Center(
                          child: Text("Devam et",
                              style: GoogleFonts.mina(
                                  fontSize: 22.sp, color: Colors.white)))),
                  SizedBox(
                      height: 80.smh,
                      width: 50.smw,
                      child: const Icon(Icons.arrow_forward_ios,
                          size: 50, color: Colors.white))
                ],
              ),
            ),
            SizedBox(height: 60.smh),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 60.smh,
                width: 300.smw,
                decoration: const BoxDecoration(
                    color: CustomThemeData.primaryColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Center(
                    child: Text("Siparişi takip et",
                        style: GoogleFonts.mina(
                            fontSize: 22.sp, color: Colors.white))),
              ),
            ),
            SizedBox(height: 15.smh),
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 60.smh,
                width: 200.smw,
                decoration: const BoxDecoration(
                    color: CustomThemeData.orderCompletedCancelColor,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        bottomLeft: Radius.circular(30))),
                child: Center(
                    child: Text("İptal et",
                        style: GoogleFonts.mina(
                            fontSize: 22.sp, color: Colors.white))),
              ),
            )
          ],
        ),
      ),
    );
  }
}
