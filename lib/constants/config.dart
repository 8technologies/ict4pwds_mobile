import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Config {
  static const String baseUrl =
      "https://observatory.ict4personswithdisabilities.org";
  static const String apiBaseUrl = "${Config.baseUrl}/api";

  static Future getUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access") != null &&
        prefs.getString("refresh") != null) {
      //if token has expired get new token
      var token = prefs.getString("access");
      bool hasExpired = JwtDecoder.isExpired(token!);
      if (hasExpired) {
        var refreshToken = prefs.getString("refresh");
        var url = "${Config.apiBaseUrl}/accounts/token/refresh/";
        try {
          Response response = await Dio().post(
            url,
            data: {'refresh': refreshToken},
          );
          prefs.setString("access", response.data['access']);
        } on DioError catch (e) {
          // ignore: avoid_print
          print(e);
        }
      }

      return prefs.getString("access");
    }

    //Todo: if token is empty go to login screen
    return prefs.getString("access");
  }

  static Future refreshToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var refreshToken = prefs.getString("refresh");
    var url = "${Config.apiBaseUrl}/accounts/token/refresh/";
    try {
      Response response = await Dio().post(
        url,
        data: {'refresh': refreshToken},
      );
      prefs.setString("access", response.data['access']);
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
    }
    return true;
  }

  static Future apiGetCall(String url, {bool force = false}) async {
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      dio.interceptors.add(DioCacheManager(CacheConfig()).interceptor);
      Response response = await dio.get(
        url,
        options: buildCacheOptions(
          const Duration(days: 10),
          maxStale: const Duration(days: 14),
          forceRefresh: force,
        ),
      );
      return response.data;
    } on DioError {
      dynamic returnedData = [];
      return returnedData;
    }
  }
}
