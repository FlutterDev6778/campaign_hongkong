import 'dart:io';

import 'package:campaign/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class QuestionnaireProvider extends ChangeNotifier {
  static QuestionnaireProvider of(BuildContext context, {bool listen = false}) => Provider.of<QuestionnaireProvider>(context, listen: listen);

  QuestionnaireState _questionnaireState = QuestionnaireState.init();
  QuestionnaireState get questionnaireState => _questionnaireState;

  void setQuestionnaireState(QuestionnaireState questionnaireState, {bool isNotifiable = true}) {
    if (_questionnaireState != questionnaireState) {
      _questionnaireState = questionnaireState;
      if (isNotifiable) notifyListeners();
    }
  }

  void getQuestionnaireData() async {
    Map<String, dynamic> questionnaireData = await QuestionnaireDataProvider.getQuestionnaireData();
    setQuestionnaireState(
      _questionnaireState.update(
        questionnaireData: questionnaireData,
        progressState: questionnaireData["success"] ? 2 : -1,
      ),
    );
  }
}
