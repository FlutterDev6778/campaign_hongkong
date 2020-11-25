// import 'package:flutter/material.dart';
// import 'package:meta/meta.dart';
// import 'package:equatable/equatable.dart';

// class OsseyScoreState extends Equatable {
//   final int progressState; // 0: init, 1: progressing, 2: success, 3: failed
//   final String errorString;
//   final int step;
//   final Map<String, dynamic> osseyScoreData;

//   OsseyScoreState({
//     @required this.errorString,
//     @required this.progressState,
//     @required this.step,
//     @required this.osseyScoreData,
//   });

//   factory OsseyScoreState.init() {
//     return OsseyScoreState(
//       progressState: 0,
//       errorString: "",
//       step: 0,
//       osseyScoreData: Map<String, dynamic>(),
//     );
//   }

//   OsseyScoreState copyWith({
//     int progressState,
//     String errorString,
//     int step,
//     Map<String, dynamic> osseyScoreData,
//   }) {
//     return OsseyScoreState(
//       progressState: progressState ?? this.progressState,
//       errorString: errorString ?? this.errorString,
//       step: step ?? this.step,
//       osseyScoreData: osseyScoreData ?? this.osseyScoreData,
//     );
//   }

//   OsseyScoreState update({
//     int progressState,
//     String errorString,
//     int step,
//     Map<String, dynamic> osseyScoreData,
//   }) {
//     return copyWith(
//       progressState: progressState,
//       errorString: errorString,
//       step: step,
//       osseyScoreData: osseyScoreData,
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       "progressState": progressState,
//       "errorString": errorString,
//       "step": step,
//       "osseyScoreData": osseyScoreData,
//     };
//   }

//   @override
//   List<Object> get props => [
//         progressState,
//         errorString,
//         step,
//         osseyScoreData,
//       ];

//   @override
//   bool get stringify => true;
// }
