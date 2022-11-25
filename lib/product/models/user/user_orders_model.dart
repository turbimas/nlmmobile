import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'package:nlmmobile/core/services/theme/custom_images.dart';
import 'package:nlmmobile/product/models/order/basket_total_model.dart';
import 'package:nlmmobile/product/models/order/order_delivery_address.dart';
import 'package:nlmmobile/product/models/order/order_invoice_address.dart';
=======
import 'package:koyevi/core/services/theme/custom_images.dart';
import 'package:koyevi/product/models/order/basket_total_model.dart';
import 'package:koyevi/product/models/order/order_delivery_address.dart';
import 'package:koyevi/product/models/order/order_invoice_address.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class UserOrdersModel {
  late final int orderId;
  late final String ficheNo;
  late final DateTime orderDate; // siparişin verildiği tarih
  DateTime? realDeliveryDate; // teslim edildiyse
  late final String statusName;
  late final int lineCount;
  late final num total;
  late final String? firstImageUrl;
  OrderDeliveryAddress? deliveryAddressDetail;
  OrderInvoiceAddress? invoiceAddressDetail;
  BasketTotalModel? orderTotals;
  late final bool refundable;
  late final bool voidable;

  Widget image({required double height, required double width}) {
    if (firstImageUrl != null) {
      return Image.network(firstImageUrl!.replaceAll("\\", "/"),
          height: height, width: width, fit: BoxFit.cover);
    } else {
      return SizedBox(
          height: height, width: width, child: CustomImages.image_not_found);
    }
  }

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderID'];
    ficheNo = json['FicheNo'];
    orderDate = DateTime.parse(json['OrderDate']);
    realDeliveryDate = json['RealDeliveryDate'] != null
        ? DateTime.parse(json['RealDeliveryDate'])
        : null;
    statusName = json['StatusName'];
    lineCount = json['LineCount'];
    total = json['Total'];
    firstImageUrl = json['FirstImageUrl'];
    deliveryAddressDetail = json['DeliveryAdressDetail'] != null
        ? OrderDeliveryAddress.fromJson(json['DeliveryAdressDetail'])
        : null;
    invoiceAddressDetail = json['InvoiceAdressDetail'] != null
        ? OrderInvoiceAddress.fromJson(json['InvoiceAdressDetail'])
        : null;
    orderTotals = json['OrderTotals'] != null
        ? BasketTotalModel.fromJson(json['OrderTotals'])
        : null;
    refundable = json["Refundable"];
    voidable = json["Voidable"];
  }
}
