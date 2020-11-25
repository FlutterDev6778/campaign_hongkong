import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class CompletedTasksState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final int step;
  final Map<String, dynamic> completedTaskData;

  CompletedTasksState({
    @required this.errorString,
    @required this.progressState,
    @required this.step,
    @required this.completedTaskData,
  });

  factory CompletedTasksState.init() {
    return CompletedTasksState(
      progressState: 0,
      errorString: "",
      step: 0,
      completedTaskData: Map<String, dynamic>(),
    );
  }

  CompletedTasksState copyWith({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> completedTaskData,
  }) {
    return CompletedTasksState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      step: step ?? this.step,
      completedTaskData: completedTaskData ?? this.completedTaskData,
    );
  }

  CompletedTasksState update({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> completedTaskData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      step: step,
      completedTaskData: completedTaskData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "step": step,
      "completedTaskData": completedTaskData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        step,
        completedTaskData,
      ];

  @override
  bool get stringify => true;
}
