import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static authUser(String username, String password) async {
    bool returned = true;
    var data = {'username': username, 'password': password};
    var url = "${Config.apiBaseUrl}/accounts/login";

    try {
      Response response = await Dio().post(url, data: data);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("access", response.data['access']);
      prefs.setString("refresh", response.data['refresh']);
    } on DioError {
      returned = false;
    }

    return returned;
  }

  static getUserFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access") != null &&
        prefs.getString("refresh") != null) {
      var token = prefs.getString("access");
      var user = JwtDecoder.decode(token!);
      return user;
    }
    return null;
  }

  static deleteUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access") != null &&
        prefs.getString("refresh") != null) {
      prefs.remove("access");
      prefs.remove("refresh");
    }
  }
}
