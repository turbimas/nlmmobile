import 'package:nlmmobile/product/models/product_over_view_model.dart';
import 'package:nlmmobile/product/models/user/user_question_answer_model.dart';

class UserQuestionModel {
  int id;
  ProductOverViewModel product;
  String contentValue;
  DateTime date;
  UserQuestionAnswerModel? answer;

  UserQuestionModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        product = ProductOverViewModel.fromJson(json['Product']),
        contentValue = json['ContentValue'],
        date = DateTime.parse(json['Date']),
        answer = json["Answer"] != null
            ? UserQuestionAnswerModel.fromJson(json['Answer'])
            : null;
}
