class ProductModel {
  final int id;
  final String barcode;
  final String name;
  final String? tradeMark;
  final double unitPrice;
  // final int varyantId;
  // final String colorName;
  // final String beden;
  // final double miktar;
  final String aciklama; // ürün ismi + açıklama
  final String unitCode;
  final double? basketQuantity;
  final int
      _favoriteId; // 0 ise favori değil, 0> ise favori buna göre getter oluşturulacak
  bool get isFavorite => _favoriteId > 0;
  final Map<String, double>? _evaluationData;
  double get evaluationCount => _evaluationData?["EvaluationsCount"] ?? 0;
  double get evaluationAvg => _evaluationData?["EvaluationsAvg"] ?? 0;
  final List<String> images;
  final List<String> thumbNails;

  ProductModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        barcode = json['Barcode'],
        name = json['Name'],
        tradeMark = json['TradeMark'],
        unitPrice = json['UnitPrice'],
        // varyantId = json['VaryantID'],
        // colorName = json['ColorName'],
        // beden = json['Beden'],
        // miktar = json['Miktar'],
        aciklama = json['Aciklama'],
        unitCode = json['UnitCode'],
        basketQuantity = json['BasketQty'],
        _favoriteId = json['FavoriteID'],
        _evaluationData = json['Evaluation'],
        images = json['Images'].cast<String>(),
        thumbNails = json['Thumbnails'].cast<String>();
}
