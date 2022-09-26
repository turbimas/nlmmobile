import 'package:nlmmobile/product/models/order/basket_total_model.dart';
import 'package:nlmmobile/product/models/order/order_delivery_address.dart';
import 'package:nlmmobile/product/models/order/order_invoice_address.dart';

class UserOrdersModel {
  late final int orderId;
  late final String ficheNo;
  late final DateTime orderDate;
  late final String statusName;
  late final int lineCount;
  late final num total;
  late final String? firstImageUrl;
  late final OrderDeliveryAddress deliveryAddressDetail;
  late final OrderInvoiceAddress invoiceAddressDetail;
  late final BasketTotalModel orderTotals;

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderID'];
    ficheNo = json['FicheNo'];
    orderDate = DateTime.parse(json['OrderDate']);
    statusName = json['StatusName'];
    lineCount = json['LineCount'];
    total = json['Total'];
    firstImageUrl = json['FirstImageUrl'];
    deliveryAddressDetail =
        OrderDeliveryAddress.fromJson(json['DeliveryAdressDetail']);
    invoiceAddressDetail =
        OrderInvoiceAddress.fromJson(json['InvoiceAdressDetail']);
    orderTotals = BasketTotalModel.fromJson(json['OrderTotals']);
  }
}
