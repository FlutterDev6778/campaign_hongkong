import 'dart:io';

import 'package:campaign/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class CompleteQuestionnaireTaskProvider extends ChangeNotifier {
  static CompleteQuestionnaireTaskProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<CompleteQuestionnaireTaskProvider>(context, listen: listen);

  CompleteQuestionnaireTaskState _completeQuestionnaireTaskState = CompleteQuestionnaireTaskState.init();
  CompleteQuestionnaireTaskState get completeQuestionnaireTaskState => _completeQuestionnaireTaskState;

  void setCompleteQuestionnaireTaskState(CompleteQuestionnaireTaskState completeQuestionnaireTaskState, {bool isNotifiable = true}) {
    if (_completeQuestionnaireTaskState != completeQuestionnaireTaskState) {
      _completeQuestionnaireTaskState = completeQuestionnaireTaskState;
      if (isNotifiable) notifyListeners();
    }
  }

  void getCompleteQuestionnaireTaskData(String cohort, double review) async {
    Map<String, dynamic> completeQuestionnaireTaskTaskData = await CompleteQuestionnaireTaskDataProvider.completeQuestionnaireTask(
      cohort: cohort,
      review: review,
    );
    setCompleteQuestionnaireTaskState(
      _completeQuestionnaireTaskState.update(
        completeQuestionnaireTaskData: completeQuestionnaireTaskTaskData,
        progressState: completeQuestionnaireTaskTaskData["success"] ? 2 : -1,
      ),
    );
  }
}
