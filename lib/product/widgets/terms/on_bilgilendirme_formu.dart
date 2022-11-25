import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/localization/locale_keys.g.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/theme/custom_images.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/try_again_widget.dart';
=======
import 'package:koyevi/core/services/localization/locale_keys.g.dart';
import 'package:koyevi/core/services/network/network_service.dart';
import 'package:koyevi/core/services/theme/custom_images.dart';
import 'package:koyevi/product/widgets/custom_appbar.dart';
import 'package:koyevi/product/widgets/custom_safearea.dart';
import 'package:koyevi/product/widgets/try_again_widget.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66
import 'package:webview_flutter/webview_flutter.dart';

class OnBilgilendirmeFormuView extends StatefulWidget {
  final int cariId;
  final int deliveryAdressId;
  final int invoiceAdressId;
  const OnBilgilendirmeFormuView(
      {super.key,
      required this.cariId,
      required this.deliveryAdressId,
      required this.invoiceAdressId});

  @override
  State<OnBilgilendirmeFormuView> createState() =>
      _OnBilgilendirmeFormuViewState();
}

class _OnBilgilendirmeFormuViewState extends State<OnBilgilendirmeFormuView> {
  bool isLoading = true;
  String? htmlData;
  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CustomSafeArea(
        child: Scaffold(
      appBar: CustomAppBar.activeBack(
          LocaleKeys.OnBilgilendirmeFormu_appbar_title.tr()),
      body: Center(
          child: isLoading
              ? CustomImages.loading
              : htmlData != null
                  ? WebView(
                      initialUrl: "about:blank",
                      onWebViewCreated: (controller) {
                        controller.loadHtmlString(htmlData!);
                      },
                    )
                  : TryAgain(callBack: _load)),
    ));
  }

  void _load() {
    setState(() {
      isLoading = true;
    });
    NetworkService.post("orders/OnBilgilendirmeFormu", body: {
      "CariID": widget.cariId,
      "DeliveryAdressID": widget.deliveryAdressId,
      "InvoiceAdressID": widget.invoiceAdressId
    }).then((value) {
      if (value.success) {
        htmlData = value.data;
      }
      setState(() {
        isLoading = false;
      });
    });
  }
}
