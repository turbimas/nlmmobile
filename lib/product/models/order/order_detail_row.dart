import 'package:nlmmobile/product/models/product_over_view_model.dart';

class OrderLinesModel {
  late int id;
  late String lineStatusName;
  late ProductOverViewModel product;
  late double amount;
  late double unitPrice;
  late double total;
  late String? notes;

  OrderLinesModel.fromJson(Map<String, dynamic> json) {
    id = json['ID'];
    lineStatusName = json['LineStatusName'];
    product = ProductOverViewModel.fromJson(json['Product']);
    amount = json['Amount'];
    unitPrice = json['UnitPrice'];
    total = json['Total'];
    notes = json['Notes'];

    product.unitPrice = unitPrice;
  }
}
