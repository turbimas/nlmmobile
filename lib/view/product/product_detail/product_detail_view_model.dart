import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/product_detail_model.dart';

class ProductDetailViewModel extends ChangeNotifier {
  ProductDetailViewModel();

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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
      isLoading = true;
      ResponseModelMap<String,
          dynamic> responseModel = await NetworkService.get<
              Map<String, dynamic>>(
          "api/products/productdetail/${AuthService.currentUser!.id}/$barcode");
      if (responseModel.success) {
        productDetail = ProductDetailModel.fromJson(responseModel.data);
      } else {
        PopupHelper.showError(errorMessage: responseModel.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    } finally {
      isLoading = false;
    }
  }

  Future<void> addBasket() async {
    try {
      productDetail!.basketQuantity ??= 0;
      productDetail!.basketQuantity = productDetail!.basketQuantity! + 1;
      notifyListeners();
      ResponseModel response =
          await NetworkService.post("api/orders/addbasket", body: {
        "CariID": AuthService.currentUser!.id,
        "Barcode": productDetail!.barcode,
        "Quantity": 1
      });

      if (!response.success) {
        productDetail!.basketQuantity = productDetail!.basketQuantity! - 1;
        if (productDetail!.basketQuantity == 0) {
          productDetail!.basketQuantity = null;
          notifyListeners();
        }
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      productDetail!.basketQuantity = productDetail!.basketQuantity! - 1;
      if (productDetail!.basketQuantity == 0) {
        productDetail!.basketQuantity = null;
        notifyListeners();
      }
      PopupHelper.showErrorWithCode(e);
    }
  }

  Future<void> updateBasket() async {
    try {
      productDetail!.basketQuantity = productDetail!.basketQuantity! - 1;
      if (productDetail!.basketQuantity! <= 0) {
        productDetail!.basketQuantity = null;
      }
      notifyListeners();
      ResponseModel response =
          await NetworkService.post("api/orders/updatebasket", body: {
        "CariID": AuthService.currentUser!.id,
        "Barcode": productDetail!.barcode,
        "Quantity": productDetail!.basketQuantity ?? 0
      });
      if (!response.success) {
        productDetail!.basketQuantity =
            (productDetail!.basketQuantity ?? 0) + 1;
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      productDetail!.basketQuantity = (productDetail!.basketQuantity ?? 0) + 1;
      PopupHelper.showErrorWithCode(e);
    }
  }

  Future<void> favoriteUpdate() async {
    try {
      ResponseModel response = await NetworkService.get(
          "api/products/favoriteupdate/${AuthService.currentUser!.id}/${productDetail!.barcode}");
      if (response.success) {
        productDetail!.isFavorite = !productDetail!.isFavorite;
        notifyListeners();
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }
}
