class UserOrdersModel {
  late final int orderId;
  late final String ficheNo;
  late final DateTime orderDate;
  late final statusName;
  late final int lineCount;
  late final num total;

  UserOrdersModel.fromJson(Map<String, dynamic> json) {
    orderId = json['OrderID'];
    ficheNo = json['FicheNo'];
    orderDate = DateTime.parse(json['OrderDate']);
    statusName = json['StatusName'];
    lineCount = json['LineCount'];
    total = json['Total'];
  }
}
