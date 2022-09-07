import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/product_detail_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  ProductDetailViewModel();

  int _imageIndex = 0;
  int get imageIndex => _imageIndex;
  set imageIndex(int value) {
    _imageIndex = value;
    _infoExpanded = false;
    notifyListeners();
  }

  int _selectedPropertyIndex = 0;
  int get selectedPropertyIndex => _selectedPropertyIndex;
  set selectedPropertyIndex(int value) {
    _selectedPropertyIndex = value;
    _infoExpanded = false;
    notifyListeners();
  }

  bool _infoExpanded = false;
  bool get infoExpanded => _infoExpanded;
  set infoExpanded(bool value) {
    _infoExpanded = value;
    notifyListeners();
  }

  ProductDetailModel? productDetail;

  Future<void> getProductDetail(String barcode) async {
    try {
      ResponseModelMap<String,
          dynamic> responseModel = await NetworkService.get<
              Map<String, dynamic>>(
          "api/products/productdetail/${AuthService.currentUser!.id}/$barcode");
      if (responseModel.success) {
        productDetail = ProductDetailModel.fromJson(responseModel.data);
        notifyListeners();
        log("product details: ${productDetail!.toJson()}");
      } else {
        PopupHelper.showError(errorMessage: responseModel.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }
}
