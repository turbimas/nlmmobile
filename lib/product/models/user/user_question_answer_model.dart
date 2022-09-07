class UserQuestionAnswerModel {
  int id;
  String contentValue;
  DateTime date;

  UserQuestionAnswerModel.fromJson(Map<String, dynamic> json)
      : id = json['ID'],
        contentValue = json['ContentValue'],
        date = DateTime.parse(json['Date']);
}
