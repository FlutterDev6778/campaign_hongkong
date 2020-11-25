import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class ArticleState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final int step;
  final Map<String, dynamic> articleData;

  ArticleState({
    @required this.errorString,
    @required this.progressState,
    @required this.step,
    @required this.articleData,
  });

  factory ArticleState.init() {
    return ArticleState(
      progressState: 0,
      errorString: "",
      step: 0,
      articleData: Map<String, dynamic>(),
    );
  }

  ArticleState copyWith({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> articleData,
  }) {
    return ArticleState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      step: step ?? this.step,
      articleData: articleData ?? this.articleData,
    );
  }

  ArticleState update({
    int progressState,
    String errorString,
    int step,
    Map<String, dynamic> articleData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      step: step,
      articleData: articleData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "step": step,
      "articleData": articleData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        step,
        articleData,
      ];

  @override
  bool get stringify => true;
}
