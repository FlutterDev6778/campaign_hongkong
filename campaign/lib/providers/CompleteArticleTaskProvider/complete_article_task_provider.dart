import 'dart:io';

import 'package:campaign/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class CompleteArticleTaskProvider extends ChangeNotifier {
  static CompleteArticleTaskProvider of(BuildContext context, {bool listen = false}) =>
      Provider.of<CompleteArticleTaskProvider>(context, listen: listen);

  CompleteArticleTaskState _completeArticleTaskState = CompleteArticleTaskState.init();
  CompleteArticleTaskState get completeArticleTaskState => _completeArticleTaskState;

  void setCompleteArticleTaskState(CompleteArticleTaskState completeArticleTaskState, {bool isNotifiable = true}) {
    if (_completeArticleTaskState != completeArticleTaskState) {
      _completeArticleTaskState = completeArticleTaskState;
      if (isNotifiable) notifyListeners();
    }
  }

  void getCompleteArticleTaskData(String cohort) async {
    Map<String, dynamic> completeArticleTaskData = await CompleteArticleTaskDataProvider.completeArticleTask(
      cohort: cohort,
    );
    setCompleteArticleTaskState(
      _completeArticleTaskState.update(
        completeArticleTaskData: completeArticleTaskData,
        progressState: completeArticleTaskData["success"] ? 2 : -1,
      ),
    );
  }
}
