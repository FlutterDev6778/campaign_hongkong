import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class QuestionnaireState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final int step;
  final Map<String, dynamic> questionnaireData;

  QuestionnaireState({
    @required this.errorString,
    @required this.progressState,
    @required this.step,
    @required this.questionnaireData,
  });

  factory QuestionnaireState.init() {
    return QuestionnaireState(
      progressState: 0,
      errorString: "",
      step: 0,
      questionnaireData: Map<String, dynamic>(),
    );
  }

  QuestionnaireState copyWith({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> questionnaireData,
  }) {
    return QuestionnaireState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      step: step ?? this.step,
      questionnaireData: questionnaireData ?? this.questionnaireData,
    );
  }

  QuestionnaireState update({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> questionnaireData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      step: step,
      questionnaireData: questionnaireData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "step": step,
      "questionnaireData": questionnaireData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        step,
        questionnaireData,
      ];

  @override
  bool get stringify => true;
}
