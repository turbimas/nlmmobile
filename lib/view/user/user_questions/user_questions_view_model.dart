import 'package:flutter/material.dart';
import 'package:nlmmobile/core/services/auth/authservice.dart';
import 'package:nlmmobile/core/services/network/network_service.dart';
import 'package:nlmmobile/core/services/network/response_model.dart';
import 'package:nlmmobile/core/utils/helpers/popup_helper.dart';
import 'package:nlmmobile/product/models/user/user_question_model.dart';

class UserQuestionsViewModel extends ChangeNotifier {
  List<UserQuestionModel> answered = [];
  List<UserQuestionModel> unanswered = [];

  int _index = 0;
  int get index => _index;
  set index(int value) {
    if (value != _index) {
      _index = value;
      notifyListeners();
    }
  }

  UserQuestionsViewModel();

  Future<void> getQuestions() async {
    try {
      ResponseModel response = await NetworkService.get(
          "api/users/questions/${AuthService.currentUser!.id}");

      if (response.success) {
        List<UserQuestionModel> questions = response.data!
            .map<UserQuestionModel>((e) => UserQuestionModel.fromJson(e))
            .toList();
        for (var element in questions) {
          if (element.answer == null) {
            unanswered.add(element);
          } else {
            answered.add(element);
          }
        }
        notifyListeners();
      } else {
        PopupHelper.showError(errorMessage: response.errorMessage);
      }
    } catch (e) {
      PopupHelper.showErrorWithCode(e);
    }
  }
}
