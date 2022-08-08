import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class PromotionsView extends StatefulWidget {
  const PromotionsView({Key? key}) : super(key: key);

  @override
  State<PromotionsView> createState() => _PromotionsViewState();
}

class _PromotionsViewState extends State<PromotionsView> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: 60.smh,
              child: Center(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back_ios_new),
                          onPressed: () {
                            Navigator.pop(context);
                          }),
                      const Text("Uygulanabilecek promosyonlar")
                    ]),
              ),
            ),
            Divider(thickness: 1.smh, height: 0.smh),
            SizedBox(height: 20.smh),
            SizedBox(
              height: 200.smh,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _promotionCard(
                      isSelected: true, prompt: "Promosyon kullanmayacağım"),
                  _promotionCard(
                      isSelected: false,
                      prompt:
                          "Tüm kuruyemiş ürünlerinde 50 TL üzeri alışverişlerinizde %10 indirim"),
                  _promotionCard(
                      isSelected: true,
                      prompt: "Tüm alışverişlerinizde geçerli %5 indirim"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  _promotionCard({required bool isSelected, required String prompt}) {
    return Container(
      height: 60.smh,
      width: 320.smw,
      decoration: BoxDecoration(
        color: const Color(0xFFB5D7C0),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
              flex: 3,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.smw),
                child: Center(
                    child: Text(prompt,
                        style: TextStyle(fontSize: 12.sp),
                        textAlign: TextAlign.center)),
              )),
          Expanded(
              flex: 1,
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0XFF22BE56)
                      : const Color(0XFF0E5B28),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Center(
                  child: isSelected
                      ? const Text("Seç", style: TextStyle(color: Colors.white))
                      : SvgPicture.asset(AssetConstants.check_circle,
                          color: Colors.white, width: 25.smh, height: 25.smh),
                ),
              ))
        ],
      ),
    );
  }
}
