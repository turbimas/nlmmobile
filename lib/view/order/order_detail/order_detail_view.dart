import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';

class OrderDetail extends ConsumerStatefulWidget {
  const OrderDetail({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OrderDetailState();
}

class _OrderDetailState extends ConsumerState<OrderDetail> {
  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar: CustomAppBar.activeBack("Sipariş Detayı"),
      body: Stack(
        children: [
          _detailExpanded(),
          Positioned(
            top: 0,
            left: 15.smw,
            right: 15.smw,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Divider(thickness: 1.smh, height: 0.smh),
                SizedBox(height: 10.smh),
                _deliveryAddress(),
                SizedBox(height: 15.smh),
                _deliveryTime(),
                SizedBox(height: 15.smh),
                _paymentType()
              ],
            ),
          )
        ],
      ),
    ));
  }

  _deliveryAddress() {
    return SizedBox(
      height: 160.smh,
      width: 330.smw,
      child: Column(
        children: [
          SizedBox(
            height: 20.smh,
            width: 330.smw,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [const Text("Teslimat adresini seçin"), _duzenleCard()],
            ),
          ),
          SizedBox(height: 10.smh),
          _radioContainer(
              height: 60,
              title: "Ofis",
              description:
                  "Güvenevler Mah. 28 Nolu Sk. No:5 Şehitkamil / Gaziantep",
              isSelected: false),
          SizedBox(height: 10.smh),
          _radioContainer(
              height: 60,
              title: "Ev",
              isSelected: true,
              description:
                  "Şahintepe Mah. 390 Nolu Cad. Edacan Sitesi A/16 Şahinbey / Gaziantep"),
        ],
      ),
    );
  }

  _deliveryTime() {
    return SizedBox(
      height: 110.smh,
      width: 330.smw,
      child: Column(
        children: [
          SizedBox(
            height: 20.smh,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text("Teslimat süresi seçin",
                  style: TextStyle(
                      fontSize: 15.sp, color: CustomThemeData.primaryColor)),
            ),
          ),
          SizedBox(height: 5.smh),
          _radioContainer(
              height: 35, title: "Hemen teslim al", isSelected: false),
          SizedBox(height: 15.smh),
          _radioContainer(
              height: 35, title: "Daha sonra teslim al", isSelected: true),
        ],
      ),
    );
  }

  _paymentType() {
    return SizedBox(
      height: 160.smh,
      width: 330.smw,
      child: Column(
        children: [
          SizedBox(
              height: 20.smh,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [const Text("Ödeme Tipini Seçin"), _duzenleCard()],
              )),
          SizedBox(height: 5.smh),
          _radioContainer(
              height: 60,
              title: "Nakit",
              isSelected: true,
              description: "Kapıda nakit ödeme"),
          SizedBox(height: 15.smh),
          _radioContainer(
              height: 60,
              title: "Enpara Şirket Kartım",
              isSelected: false,
              description: "3789 **** **** **89",
              trailing: SvgPicture.asset(AssetConstants.mastercard,
                  height: 18.smh, width: 34.smw)),
        ],
      ),
    );
  }

  Container _duzenleCard() {
    return Container(
      height: 20.smh,
      width: 60.smw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color(0xFF0F8235),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SvgPicture.asset(AssetConstants.edit,
              height: 10.smh, width: 10.smh, color: Colors.white),
          Text("Düzenle", style: TextStyle(fontSize: 8.sp, color: Colors.white))
        ],
      ),
    );
  }

  Widget _detailExpanded() {
    return Positioned(
      bottom: 0,
      child: Container(
        color: Colors.transparent,
        height: 225.smh,
        width: AppConstants.designWidth.smw,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            _kampanyaMessage(),
            Container(
              height: 200.smh,
              width: AppConstants.designWidth.smw,
              decoration: BoxDecoration(
                gradient: CustomThemeData.paymentDetailGradient,
                boxShadow: [
                  BoxShadow(
                      color: const Color(0xFF50745C).withOpacity(0.5),
                      blurRadius: 25,
                      blurStyle: BlurStyle.inner)
                ],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {},
                    child: Container(
                      // ödemeye git
                      height: 50.smh,
                      width: 300.smw,
                      decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30)),
                          gradient: CustomThemeData.paymentDetailGradient),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SvgPicture.asset(AssetConstants.coupon,
                              color: Colors.black,
                              height: 22.smh,
                              width: 32.smw),
                          const Text("Ödemeye git")
                        ],
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.transparent,
                    margin: EdgeInsets.symmetric(
                        horizontal: 25.smw, vertical: 10.smh),
                    height: 80.smh,
                    width: AppConstants.designWidth.smw,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("... Miktarı"),
                            Text("23,65 TL")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("... Miktarı"),
                            Text("53.23 TL")
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("... Miktarı"),
                            Text("76.42 TL")
                          ],
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 1.smh, height: 1.smh),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25.smw),
                    color: Colors.transparent,
                    height: 49.smh,
                    width: AppConstants.designWidth.smw,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("TOPLAM TUTAR"),
                        Text("1652.42 TL")
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Container _kampanyaMessage() {
    return Container(
        width: 260.smw,
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        height: 25.smh,
        alignment: Alignment.center,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.smw),
          child: Text(
            "32 Tl tutarında alışveriş yaparsanız teslimat ücreti yok!!",
            style: TextStyle(fontSize: 10.sp),
            textAlign: TextAlign.center,
            overflow: TextOverflow.visible,
            maxLines: 1,
          ),
        ));
  }

  _radioContainer(
      {required double height,
      required String title,
      Widget? trailing,
      String? description,
      required bool isSelected}) {
    return Container(
      height: height.smh,
      decoration: BoxDecoration(
          color: CustomThemeData.primaryColor,
          borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5.smh),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                flex: 1,
                child: Center(
                  child: SvgPicture.asset(
                      isSelected
                          ? AssetConstants.radio_button_checked
                          : AssetConstants.radio_button_unchecked,
                      color: Colors.white,
                      height: 20.smh,
                      width: 20.smh),
                )),
            Expanded(
                flex: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(title,
                        style: TextStyle(color: Colors.white, fontSize: 12.sp)),
                    description != null
                        ? Text(description,
                            style:
                                TextStyle(color: Colors.white, fontSize: 10.sp))
                        : const SizedBox()
                  ],
                )),
            Expanded(flex: 1, child: trailing ?? Container()),
          ],
        ),
      ),
    );
  }
}
