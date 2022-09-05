import 'package:flutter/material.dart';

class UserQuestionsViewModel extends ChangeNotifier {
  // List<QuestionModel> answered =
  //     List.generate(10, (index) => QuestionModel.testAnswered());
  // List<QuestionModel> unanswered =
  //     List.generate(10, (index) => QuestionModel.testUnanswered());

  int _index = 0;
  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;
      notifyListeners();
    }
  }

  UserQuestionsViewModel();
}
