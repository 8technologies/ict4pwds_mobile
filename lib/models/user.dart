import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';

class User {
  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final bool? isActive;
  final String? username;
  final String? fullName;
  final String? profilePic;
  final String? phoneNumber;
  final String? gender;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.isActive,
    this.username,
    this.fullName,
    this.profilePic,
    this.phoneNumber,
    this.gender,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      isActive: json['is_active'],
      username: json['username'],
      fullName: json['full_name'],
      profilePic: json['profile_pic'],
      phoneNumber: json['phone_number'],
      gender: json['gender'],
    );
  }

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
      if (error == "Error Authenticating User") {
        return "Error Authenticating User";
      }
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

  static upDateProfile(int id, String name, String phone) async {
    var splitName = Helpers.getLastNameCommaFirstName(name);
    var firstName = splitName[1];
    var lastName = splitName[0];

    var data = {
      "first_name": firstName,
      "last_name": lastName,
      "phone_number": phone,
      "gender": null
    };

    var url = "${Config.apiBaseUrl}/accounts/profiles/$id/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      await dio.patch(url, data: data);
      return "success";
    } on DioError catch (e) {
      print(e);
      return "Error updating account information";
    }
  }

  static getUserProfile(int id) async {
    var url = "${Config.apiBaseUrl}/accounts/profiles/$id/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      final prefs = await SharedPreferences.getInstance();
      Map jsonResponse = response.data;
      bool result = await prefs.setString('user', jsonEncode(jsonResponse));
      if (result) {
        return true;
      }
      return false;
    } on DioError {
      return false;
    }
  }

  static getUserFromToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access") != null &&
        prefs.getString("refresh") != null) {
      var token = prefs.getString("access");
      var user = JwtDecoder.decode(token!);
      return user['id'];
    }
    return null;
  }

  static Future getPrefUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('user') != null) {
      String? userPref = prefs.getString('user');
      Map user = jsonDecode(userPref!);
      return user;
    }

    var id = await User.getUserFromToken();
    var user = await User.getUserProfile(id);
    if (user) {
      String? userPref = prefs.getString('user');
      Map user = jsonDecode(userPref!);
      return user;
    }
  }

  static deleteUserToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("access") != null &&
        prefs.getString("refresh") != null) {
      prefs.remove("access");
      prefs.remove("refresh");
    }
  }

  static resetPassword(String email) async {
    var data = {
      "email": email,
    };

    var url = "${Config.apiBaseUrl}/accounts/password_reset/";
    try {
      await Dio().post(url, data: data);
      return "success";
    } on DioError catch (e) {
      //print(e);
      return "Error requesting password reset";
    }
  }

  static confirmPWReset(String password, String token) async {
    var data = {
      "password": password,
      "token": token
    };

    var url = "${Config.apiBaseUrl}/accounts/password_reset/confirm/";
    try {
      await Dio().post(url, data: data);
      return "success";
    } on DioError catch (e) {
      //print(e);
      return "Error resetting password";
    }
  }
}
