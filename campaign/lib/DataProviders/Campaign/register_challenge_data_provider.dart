import 'dart:convert';

import 'package:campaign/DataProviders/api_config.dart';
import 'package:campaign/DataProviders/apis.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

class RegisterChallengeDataProvider {
  static registerChallenge({
    String authToken = "",
    String psid = "69904d92-b1f1-11ea-81a7-0a7a347b3dd5",
  }) async {
    String baseUrl = ApiConfig.getBaseUrl();
    try {
      var response = await http.post(
        baseUrl + CampaignApis.challenges21Days + "/$psid",
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
        "data": "/21_days_challenge api error",
      };
    }
  }
}
