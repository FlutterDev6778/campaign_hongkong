import 'dart:io';

import 'package:campaign/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class CompletedTasksProvider extends ChangeNotifier {
  static CompletedTasksProvider of(BuildContext context, {bool listen = false}) => Provider.of<CompletedTasksProvider>(context, listen: listen);

  CompletedTasksState _completedTasksState = CompletedTasksState.init();
  CompletedTasksState get completedTasksState => _completedTasksState;

  void setCompletedTasksState(CompletedTasksState completedTasksState, {bool isNotifiable = true}) {
    if (_completedTasksState != completedTasksState) {
      _completedTasksState = completedTasksState;
      if (isNotifiable) notifyListeners();
    }
  }

  Future<void> getCompletedTasksData() async {
    Map<String, dynamic> completedTaskData = await CompletedTasksDataProvider.getCompletedTasksData();
    setCompletedTasksState(
      _completedTasksState.update(
        completedTaskData: completedTaskData,
        progressState: completedTaskData["success"] ? 2 : -1,
      ),
    );
  }
}
