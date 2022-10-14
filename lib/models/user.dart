import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
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
}
