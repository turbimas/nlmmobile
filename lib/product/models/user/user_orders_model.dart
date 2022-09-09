import 'package:nlmmobile/product/models/order/basket_total_model.dart';
import 'package:nlmmobile/product/models/order/order_delivery_address.dart';
import 'package:nlmmobile/product/models/order/order_invoice_address.dart';

class UserOrdersModel {
  late final int OrderID;
  late final String FicheNo;
  late final DateTime OrderDate;
  late final StatusName;
  late final int LineCount;
  late final num Total;
  late final String? FirstImageUrl;
  late final OrderDeliveryAddress DeliveryAdressDetail;
  late final OrderInvoiceAddress InvoiceAdressDetail;
  late final BasketTotalModel OrderTotals;

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    OrderID = json['OrderID'];
    FicheNo = json['FicheNo'];
    OrderDate = DateTime.parse(json['OrderDate']);
    StatusName = json['StatusName'];
    LineCount = json['LineCount'];
    Total = json['Total'];
    FirstImageUrl = json['FirstImageUrl'];
    DeliveryAdressDetail =
        OrderDeliveryAddress.fromJson(json['DeliveryAdressDetail']);
    InvoiceAdressDetail =
        OrderInvoiceAddress.fromJson(json['InvoiceAdressDetail']);
    OrderTotals = BasketTotalModel.fromJson(json['OrderTotals']);
  }
}
