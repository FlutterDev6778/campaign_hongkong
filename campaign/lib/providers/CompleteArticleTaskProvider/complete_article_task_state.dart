import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class CompleteArticleTaskState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final int step;
  final Map<String, dynamic> completeArticleTaskData;

  CompleteArticleTaskState({
    @required this.errorString,
    @required this.progressState,
    @required this.step,
    @required this.completeArticleTaskData,
  });

  factory CompleteArticleTaskState.init() {
    return CompleteArticleTaskState(
      progressState: 0,
      errorString: "",
      step: 0,
      completeArticleTaskData: Map<String, dynamic>(),
    );
  }

  CompleteArticleTaskState copyWith({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> completeArticleTaskData,
  }) {
    return CompleteArticleTaskState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      step: step ?? this.step,
      completeArticleTaskData: completeArticleTaskData ?? this.completeArticleTaskData,
    );
  }

  CompleteArticleTaskState update({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> completeArticleTaskData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      step: step,
      completeArticleTaskData: completeArticleTaskData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "step": step,
      "completeArticleTaskData": completeArticleTaskData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        step,
        completeArticleTaskData,
      ];

  @override
  bool get stringify => true;
}
