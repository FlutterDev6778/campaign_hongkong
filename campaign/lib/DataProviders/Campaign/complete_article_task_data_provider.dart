import 'dart:convert';

import 'package:campaign/DataProviders/api_config.dart';
import 'package:campaign/DataProviders/apis.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:date_time_format/date_time_format.dart';

class CompleteArticleTaskDataProvider {
  static completeArticleTask({
    String authToken = "",
    String psid = "69904d92-b1f1-11ea-81a7-0a7a347b3dd5",
    String cohort = "c1",
  }) async {
    String baseUrl = ApiConfig.getBaseUrl();
    try {
      var response = await http.post(
        baseUrl + CampaignApis.completArticleTask + "/$psid" + "/$cohort",
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
        "data": "${CampaignApis.completArticleTask} api error",
      };
    }
  }
}
