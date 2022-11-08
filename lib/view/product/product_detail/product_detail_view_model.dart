import 'package:flutter/material.dart';
import 'package:nlmdev/core/services/auth/authservice.dart';
import 'package:nlmdev/core/services/network/network_service.dart';
import 'package:nlmdev/core/services/network/response_model.dart';
import 'package:nlmdev/core/utils/helpers/popup_helper.dart';
import 'package:nlmdev/product/models/product_detail_model.dart';

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
      ResponseModelMap<String, dynamic> responseModel =
          await NetworkService.get<Map<String, dynamic>>(
              "products/productdetail/${AuthService.currentUser!.id}/$barcode");
      if (responseModel.success) {
        productDetail = ProductDetailModel.fromJson(responseModel.data!);
      } else {
        PopupHelper.showErrorDialog(errorMessage: responseModel.errorMessage!);
      }
    } catch (e) {
      PopupHelper.showErrorDialogWithCode(e);
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
          await NetworkService.post("orders/addbasket", body: {
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
        PopupHelper.showErrorDialog(errorMessage: response.errorMessage!);
      }
    } catch (e) {
      productDetail!.basketQuantity = productDetail!.basketQuantity! - 1;
      if (productDetail!.basketQuantity == 0) {
        productDetail!.basketQuantity = null;
        notifyListeners();
      }
      PopupHelper.showErrorDialogWithCode(e);
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
          await NetworkService.post("orders/updatebasket", body: {
        "CariID": AuthService.currentUser!.id,
        "Barcode": productDetail!.barcode,
        "Quantity": productDetail!.basketQuantity ?? 0
      });
      if (!response.success) {
        productDetail!.basketQuantity =
            (productDetail!.basketQuantity ?? 0) + 1;
        PopupHelper.showErrorDialog(errorMessage: response.errorMessage!);
      }
    } catch (e) {
      productDetail!.basketQuantity = (productDetail!.basketQuantity ?? 0) + 1;
      PopupHelper.showErrorDialogWithCode(e);
    }
  }

  Future<void> favoriteUpdate() async {
    try {
      ResponseModel response = await NetworkService.get(
          "products/favoriteupdate/${AuthService.currentUser!.id}/${productDetail!.barcode}");
      if (response.success) {
        productDetail!.isFavorite = !productDetail!.isFavorite;
        PopupHelper.showSuccessToast(productDetail!.isFavorite
            ? "Ürün favorilere eklendi"
            : "Ürün favorilerden çıkarıldı");
        notifyListeners();
      } else {
        PopupHelper.showErrorDialog(errorMessage: response.errorMessage!);
      }
    } catch (e) {
      PopupHelper.showErrorDialogWithCode(e);
    }
  }
}
