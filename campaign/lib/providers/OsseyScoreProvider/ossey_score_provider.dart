// import 'dart:io';

// import 'package:campaign/DataProviders/index.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import 'index.dart';

// class OsseyScoreProvider extends ChangeNotifier {
//   static OsseyScoreProvider of(BuildContext context, {bool listen = false}) => Provider.of<OsseyScoreProvider>(context, listen: listen);

//   OsseyScoreState _osseyScoreState = OsseyScoreState.init();
//   OsseyScoreState get osseyScoreState => _osseyScoreState;

//   void setOsseyScoreState(OsseyScoreState osseyScoreState, {bool isNotifiable = true}) {
//     if (_osseyScoreState != osseyScoreState) {
//       _osseyScoreState = osseyScoreState;
//       if (isNotifiable) notifyListeners();
//     }
//   }

//   void getOsseyScoreData() async {
//     Map<String, dynamic> osseyScoreData = await OsseyScoreDataProvider.getOsseyScoreData();
//     setOsseyScoreState(
//       _osseyScoreState.update(
//         osseyScoreData: osseyScoreData,
//         progressState: osseyScoreData["success"] ? 2 : -1,
//       ),
//     );
//   }
// }
