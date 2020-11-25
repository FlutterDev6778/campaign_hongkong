import 'package:campaign/Config/index.dart';

class ApiConfig {
  static String baseUrlForDev = "https://mcuhhxkn9e.execute-api.us-east-1.amazonaws.com/dev";
  static String baseUrlForProd = "https://mcuhhxkn9e.execute-api.us-east-1.amazonaws.com/dev";

  static String getBaseUrl() {
    return (AppConfig.env == Environment.Dev) ? ApiConfig.baseUrlForDev : ApiConfig.baseUrlForProd;
  }
}
