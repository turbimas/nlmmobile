class ProductDetailModel {
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
  double? basketQuantity;
  int favoriteId; // 0 ise favori değil, 0> ise favori buna göre getter oluşturulacak
  bool get isFavorite => favoriteId > 0;
  set isFavorite(bool value) {
    favoriteId = value ? 1 : 0;
  }

  final Map<String, dynamic>? _evaluationData;
  num get evaluationCount =>
      _evaluationData != null ? _evaluationData!["EvaluationsCount"] ?? 0 : 0;
  num get evaluationAverage =>
      _evaluationData != null ? _evaluationData!["EvaluationsAvg"] ?? 0 : 0;

  final List<String> _images;
  final List<String> _thumbNails;
  List<String> get images => _images
      .map((e) => "http://${e.replaceAll("\\", "/").replaceAll("//", "/")}")
      .toList();
  List<String> get thumbNails => _thumbNails
      .map((e) => "http://${e.replaceAll("\\", "/").replaceAll("//", "/")}")
      .toList();

  ProductDetailModel.fromJson(Map<String, dynamic> json)
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
        favoriteId = json['FavoriteID'],
        _evaluationData = json['Evaluation'],
        _images = json['Images'].cast<String>(),
        _thumbNails = json['Thumbnails'].cast<String>();

  toJson() {
    return {
      'ID': id,
      'Barcode': barcode,
      'Name': name,
      'TradeMark': tradeMark,
      'UnitPrice': unitPrice,
      // 'VaryantID': varyantId,
      // 'ColorName': colorName,
      // 'Beden': beden,
      // 'Miktar': miktar,
      'Aciklama': aciklama,
      'UnitCode': unitCode,
      'BasketQty': basketQuantity,
      'FavoriteID': favoriteId,
      'Evaluation': _evaluationData,
      'Images': images,
      'Thumbnails': thumbNails,
    };
  }
}
