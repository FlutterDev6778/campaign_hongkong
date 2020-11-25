import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class TodayTasksState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final int step;
  final Map<String, dynamic> todayTaskData;

  TodayTasksState({
    @required this.errorString,
    @required this.progressState,
    @required this.step,
    @required this.todayTaskData,
  });

  factory TodayTasksState.init() {
    return TodayTasksState(
      progressState: 0,
      errorString: "",
      step: 0,
      todayTaskData: Map<String, dynamic>(),
    );
  }

  TodayTasksState copyWith({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> todayTaskData,
  }) {
    return TodayTasksState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      step: step ?? this.step,
      todayTaskData: todayTaskData ?? this.todayTaskData,
    );
  }

  TodayTasksState update({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> todayTaskData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      step: step,
      todayTaskData: todayTaskData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "step": step,
      "todayTaskData": todayTaskData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        step,
        todayTaskData,
      ];

  @override
  bool get stringify => true;
}
