import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:nlmmobile/core/services/theme/custom_theme_data.dart';
import 'package:nlmmobile/core/utils/extentions/ui_extention.dart';
import 'package:nlmmobile/product/constants/app_constants.dart';
import 'package:nlmmobile/product/constants/asset_constants.dart';
import 'package:nlmmobile/product/cubits/home_index_cubit/home_index_cubit.dart';
import 'package:nlmmobile/product/widgets/product_overview/product_overview_view.dart';
import 'package:nlmmobile/product/widgets/searchbar/searchbar_view.dart';
import 'package:nlmmobile/view/main/basket/basket_viewmodel.dart';
import 'package:nlmmobile/view/order/order_detail/order_detail_view.dart';

class BasketView extends ConsumerStatefulWidget {
  const BasketView({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _BasketViewState();
}

class _BasketViewState extends ConsumerState<BasketView> {
  ChangeNotifierProvider<BasketViewModel> provider =
      ChangeNotifierProvider((ref) => BasketViewModel());

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _body(),
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
          top: 10.smh,
          left: 15.smw,
          right: 15.smw,
          child: Column(children: [
            const SearchBarView(hint: "Sepette ürün ara"),
            SizedBox(height: 10.smh),
            SizedBox(
              height: 790.smh,
              child: GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisExtent: 250.smh,
                    crossAxisSpacing: 10.smw,
                    mainAxisSpacing: 10.smh),
                itemCount: 10,
                itemBuilder: (context, index) => const ProductOverviewView(),
              ),
            ),
          ]),
        ),
        _detail()
      ],
    );
  }

  Widget _empty() {
    return Padding(
      padding: EdgeInsets.only(
          left: 14.smw, right: 14.smw, top: 185.smh, bottom: 237.smh),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(AssetConstants.basket_empty,
                height: 170.smh, width: 170.smw),
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
                width: 330.smw,
                height: 70.smh,
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
    return Positioned(
      bottom: 75.smh,
      child: SizedBox(
        height: 125.smh,
        child: Column(
          children: [
            _kampanyaMessage(),
            Container(
              height: 100.smh,
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF50745C).withOpacity(0.5),
                    blurRadius: 25,
                    blurStyle: BlurStyle.inner,
                  )
                ],
                gradient: CustomThemeData.paymentDetailGradient,
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.smw),
                    height: 59.5.smh,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return const OrderDetail();
                            }));
                          },
                          child: Container(
                              height: 40.smh,
                              width: 175.smw,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Colors.green),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  SvgPicture.asset(AssetConstants.coupon,
                                      color: Colors.white,
                                      height: 20.smh,
                                      width: 20.smw),
                                  const Text("Promosyon kullan",
                                      style: TextStyle(
                                        color: Colors.white,
                                      ))
                                ],
                              )),
                        ),
                        SizedBox(width: 20.smw),
                        InkWell(
                          onTap: () {},
                          child: Container(
                            height: 40.smh,
                            width: 145.smw,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(90),
                                boxShadow: [
                                  BoxShadow(
                                      blurRadius: 10,
                                      spreadRadius: 3,
                                      offset: Offset(0, 4.smh),
                                      color: Colors.black.withOpacity(0.25))
                                ],
                                color: Colors.white),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                SvgPicture.asset(
                                    AssetConstants.shopping_card_arrow_down,
                                    height: 20.smh,
                                    width: 20.smw,
                                    color: Colors.black),
                                const Text("Sepeti onayla")
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Divider(thickness: 1.smh, height: 1.smh),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10.smw),
                    height: 39.5.smh,
                    width: AppConstants.designWidth.smw,
                    color: Colors.transparent,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("Toplam tutar"),
                        Text("32 TL"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detailExpanded() {
    return Positioned(
      bottom: 75.smh,
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
}
