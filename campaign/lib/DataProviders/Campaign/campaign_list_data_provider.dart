import 'dart:convert';

import 'package:campaign/DataProviders/api_config.dart';
import 'package:campaign/DataProviders/apis.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class CampaignListDataProvider {
  static getCampaignListData({String authToken = ""}) async {
    String baseUrl = ApiConfig.getBaseUrl();

    try {
      var response = await http.get(
        baseUrl + CampaignApis.campaignList,
        headers: {
          'Authorization': 'Bearer $authToken',
          'Content-Type': 'application/json',
        },
      );

      return json.decode(response.body);
    } on PlatformException catch (e) {
      return {
        "success": false,
        "error": true,
        "data": e.message,
      };
    } catch (e) {
      print(e);
      return {
        "success": false,
        "error": true,
        "data": e,
      };
    }
  }
}
