<<<<<<< HEAD
import 'package:nlmmobile/product/models/product_over_view_model.dart';
=======
import 'package:koyevi/product/models/product_over_view_model.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class HomeBannerModel {
  late final String title;
  late final int type;
  late final String typeName;
  late final int order;
  late final String _bannerUrl;
  String get bannerUrl => _bannerUrl.replaceAll("\\", "/");
  List<String> barcodes = [];
  List<ProductOverViewModel> products = [];

  HomeBannerModel.fromJson(Map<String, dynamic> json) {
    title = json['Tittle'];
    type = json['Type'];
    typeName = json['TypeName'];
    order = json['Order'];
    _bannerUrl = json['BannerUrl'];
    barcodes = json['Barcodes'].cast<String>();
    products = (json['Products'] as List)
        .map((e) => ProductOverViewModel.fromJson(e))
        .toList();
  }
}
