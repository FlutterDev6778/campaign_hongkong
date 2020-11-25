import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class RegisterChallengeState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final int step;
  final Map<String, dynamic> registerChallengeData;

  RegisterChallengeState({
    @required this.errorString,
    @required this.progressState,
    @required this.step,
    @required this.registerChallengeData,
  });

  factory RegisterChallengeState.init() {
    return RegisterChallengeState(
      progressState: 0,
      errorString: "",
      step: 0,
      registerChallengeData: Map<String, dynamic>(),
    );
  }

  RegisterChallengeState copyWith({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> registerChallengeData,
  }) {
    return RegisterChallengeState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      step: step ?? this.step,
      registerChallengeData: registerChallengeData ?? this.registerChallengeData,
    );
  }

  RegisterChallengeState update({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> registerChallengeData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      step: step,
      registerChallengeData: registerChallengeData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "step": step,
      "registerChallengeData": registerChallengeData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        step,
        registerChallengeData,
      ];

  @override
  bool get stringify => true;
}
