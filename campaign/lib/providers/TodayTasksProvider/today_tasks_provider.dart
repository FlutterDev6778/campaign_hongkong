import 'dart:io';

import 'package:campaign/DataProviders/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'index.dart';

class TodayTasksProvider extends ChangeNotifier {
  static TodayTasksProvider of(BuildContext context, {bool listen = false}) => Provider.of<TodayTasksProvider>(context, listen: listen);

  TodayTasksState _todayTasksState = TodayTasksState.init();
  TodayTasksState get todayTasksState => _todayTasksState;

  void setTodayTasksState(TodayTasksState todayTasksState, {bool isNotifiable = true}) {
    if (_todayTasksState != todayTasksState) {
      _todayTasksState = todayTasksState;
      if (isNotifiable) notifyListeners();
    }
  }

  void getTodayTasksData() async {
    Map<String, dynamic> todayTaskData = await TodayTasksDataProvider.getTodayTasksData();
    setTodayTasksState(
      _todayTasksState.update(
        todayTaskData: todayTaskData,
        progressState: todayTaskData["success"] ? 2 : -1,
      ),
    );
  }
}
