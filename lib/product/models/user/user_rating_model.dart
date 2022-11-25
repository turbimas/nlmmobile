<<<<<<< HEAD
import 'package:nlmmobile/product/models/product_over_view_model.dart';
=======
import 'package:koyevi/product/models/product_over_view_model.dart';
>>>>>>> b93235d9667607c51079d8a94bbbb9f4b80d0a66

class UserRatingModel {
  int id;
  ProductOverViewModel product;
  num ratingValue;
  String? contentValue;
  DateTime date;

  UserRatingModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        product = ProductOverViewModel.fromJson(json['Product']),
        ratingValue = json['RatingValue'],
        contentValue = json['ContentValue'],
        date = DateTime.parse(json['Date']);
}
