class BasketTotalModel {
  late double lineTotal;
  late double deliveryTotal;
  late double promotionTotal;
  late double generalTotal;

  BasketTotalModel.fromJson(Map<String, dynamic> json)
      : lineTotal = json['LineTotal'],
        deliveryTotal = json['DeliveryTotal'],
        promotionTotal = json['PromotionTotal'],
        generalTotal = json['GeneralTotal'];
}
