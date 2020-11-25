import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

class HomePageState extends Equatable {
  final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
  final String errorString;
  final Map<String, dynamic> campaignListData;

  HomePageState({
    @required this.errorString,
    @required this.progressState,
    @required this.campaignListData,
  });

  factory HomePageState.init() {
    return HomePageState(
      progressState: 0,
      errorString: "",
      campaignListData: {"success": false},
    );
  }

  HomePageState copyWith({
    int progressState,
    String errorString,
    Map<String, dynamic> campaignListData,
  }) {
    return HomePageState(
      progressState: progressState ?? this.progressState,
      errorString: errorString ?? this.errorString,
      campaignListData: campaignListData ?? this.campaignListData,
    );
  }

  HomePageState update({
    int progressState,
    String errorString,
    Map<String, dynamic> campaignListData,
  }) {
    return copyWith(
      progressState: progressState,
      errorString: errorString,
      campaignListData: campaignListData,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "progressState": progressState,
      "errorString": errorString,
      "campaignListData": campaignListData,
    };
  }

  @override
  List<Object> get props => [
        progressState,
        errorString,
        campaignListData,
      ];

  @override
  bool get stringify => true;
}
