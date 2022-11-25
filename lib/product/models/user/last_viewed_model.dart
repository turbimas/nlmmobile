<<<<<<< HEAD
import 'package:nlmmobile/product/models/product_over_view_model.dart';
=======
import 'package:koyevi/product/models/product_over_view_model.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class LastViewedModel {
  int id;
  DateTime date;
  ProductOverViewModel product;

  LastViewedModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        date = DateTime.parse(json['Date']),
        product = ProductOverViewModel.fromJson(json['Product']);
}
