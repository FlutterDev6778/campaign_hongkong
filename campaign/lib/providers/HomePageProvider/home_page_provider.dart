import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:keicy_utils/local_storage.dart';

import 'package:campaign/DataProviders/index.dart';

import 'index.dart';

class HomePageProvider extends ChangeNotifier {
  static HomePageProvider of(BuildContext context, {bool listen = false}) => Provider.of<HomePageProvider>(context, listen: listen);

  HomePageState _homePageState = HomePageState.init();
  HomePageState get homePageState => _homePageState;

  void setHomePageState(HomePageState homePageState, {bool isNotifiable = true}) {
    if (_homePageState != homePageState) {
      _homePageState = homePageState;
      if (isNotifiable) notifyListeners();
    }
  }

  void getCampaignListData() async {
    Map<String, dynamic> localStorageData = Map<String, dynamic>();
    bool callApi = true;

    if (LocalStorage.instance.sharedPreferences == null) {
      await LocalStorage.instance.init();
    }

    /// get campaignList from local storage
    var data = await LocalStorage.instance.getDataInLocal(key: "CampaignList", type: StorableDataType.String);
    localStorageData = data == null ? null : json.decode(data);

    if (localStorageData != null &&
        localStorageData["list"]["success"] &&
        DateTime.fromMillisecondsSinceEpoch(localStorageData["date"]).day == DateTime.now().day &&
        DateTime.fromMillisecondsSinceEpoch(localStorageData["date"]).month == DateTime.now().month &&
        DateTime.fromMillisecondsSinceEpoch(localStorageData["date"]).year == DateTime.now().year) {
      callApi = false;
    }

    HomePageState homePageState = _homePageState;

    if (callApi) {
      Map<String, dynamic> campaignListData = await CampaignListDataProvider.getCampaignListData();
      if (campaignListData["success"]) {
        homePageState = _homePageState.update(campaignListData: campaignListData, errorString: "");

        /// store campaignList to local storage
        LocalStorage.instance.storeDataToLocal(
          key: "CampaignList",
          value: json.encode({"date": DateTime.now().millisecondsSinceEpoch, "list": campaignListData}),
          type: StorableDataType.String,
        );
      } else if (localStorageData != null && localStorageData["list"]["success"]) {
        homePageState = _homePageState.update(campaignListData: localStorageData["list"], errorString: "api failed");
      } else {
        homePageState = _homePageState.update(errorString: "api error");
      }
    } else if (localStorageData != null && localStorageData["list"]["success"]) {
      homePageState = _homePageState.update(campaignListData: localStorageData["list"], errorString: "");
    } else {
      homePageState = _homePageState.update(errorString: "empty local");
    }

    setHomePageState(homePageState);
  }
}
