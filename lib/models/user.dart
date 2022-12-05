import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  static authUser(String username, String password) async {
    var data = {'username': username, 'password': password};
    var url = "${Config.apiBaseUrl}/accounts/login";

    try {
      Response response = await Dio().post(url, data: data);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString("access", response.data['access']);
      prefs.setString("refresh", response.data['refresh']);
      return "success";
    } on DioError catch (e) {
      var error = e.response!.data['error'] ?? "Error Authenticating User";
      if (error == "Error Authenticating User") return "Error Authenticating User";
      return error[0];

    }
  }

  static createUser(String name, String email, String password) async {
    var splitName = Helpers.getLastNameCommaFirstName(name);
    var firstName = splitName[1];
    var lastName = splitName[0];

    var data = {
      "username": email,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "profile": {"gender": null}
    };

    var url = "${Config.apiBaseUrl}/accounts/register/";
    try {
      await Dio().post(url, data: data);
      return "success";
    } on DioError catch (e) {
      var message = e.response!.data['username'] ?? "Error creating Account";
      if (message == "Error creating Account") return "Error creating Account";
      return "Account already registered";
    }
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
