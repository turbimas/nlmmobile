import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/theme/custom_images.dart';

class ProductOverViewModel {
  final int id;
  final String barcode;
  final String name;
  final String? tradeMark;
  final double unitPrice;
  // int varyantId
  // String colorName
  // String beden
  final String aciklama;
  final String unitCode;
  final String? _thumbnail;
  double? basketQuantity;
  int _favoriteId;
  bool get isFavorite => _favoriteId > 0;
  set favoriteId(int id) {
    _favoriteId = id;
  }

  final Map<String, dynamic>? _evaluationData;
  num get evaluationCount =>
      _evaluationData != null ? _evaluationData!["EvaluationsCount"] ?? 0 : 0;
  num get evaluationAverage =>
      _evaluationData != null ? _evaluationData!["EvaluationsAverage"] ?? 0 : 0;

  Widget image({required double height, required double width}) =>
      _thumbnail != null
          ? Image.network(
              "http://${_thumbnail!.replaceAll("\\", "/").replaceAll("//", "/")}",
              height: height,
              width: width,
              fit: BoxFit.fill,
            )
          : CustomImages.image_not_found;

  ProductOverViewModel.fromJson(Map<String, dynamic> json)
      : id = json["ID"],
        barcode = json["Barcode"],
        name = json["Name"],
        tradeMark = json["TradeMark"],
        unitPrice = json["UnitPrice"],
        aciklama = json["Aciklama"],
        unitCode = json["UnitCode"],
        _thumbnail = json["MainImageThumbUrl"],
        basketQuantity = json["BasketQty"],
        _favoriteId = json["FavoriteID"],
        _evaluationData = json["Evaluation"];
}
