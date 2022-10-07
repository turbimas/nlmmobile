import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/theme/custom_images.dart';
import 'package:nlmmobile/product/widgets/custom_appbar.dart';
import 'package:nlmmobile/product/widgets/custom_safearea.dart';
import 'package:nlmmobile/product/widgets/try_again_widget.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MesafeliSatisSozlesmesi extends StatefulWidget {
  final int cariId;
  final int deliveryAdressId;
  final int invoiceAdressId;
  const MesafeliSatisSozlesmesi(
      {required this.cariId,
      required this.deliveryAdressId,
      required this.invoiceAdressId});

  @override
  State<MesafeliSatisSozlesmesi> createState() =>
      _MesafeliSatisSozlesmesiState();
}

class _MesafeliSatisSozlesmesiState extends State<MesafeliSatisSozlesmesi> {
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
      appBar: CustomAppBar.activeBack("Mesafeli Satış Sözleşmesi"),
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
    NetworkService.post("orders/MesafeliSatisSozlesmesi", body: {
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
