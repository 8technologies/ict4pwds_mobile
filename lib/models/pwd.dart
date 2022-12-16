import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Pwd {
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

  Pwd({
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

  factory Pwd.fromJson(Map<String, dynamic> json) {
    return Pwd(
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

  static getProfile(int id) async {
    var url =
        "${Config.apiBaseUrl}/persons_with_disabilities/persons/?user=$id";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      final prefs = await SharedPreferences.getInstance();
      List jsonResponse = response.data["results"];
      if (jsonResponse.isEmpty) {
        jsonResponse.add({"id": null});
      }
      bool result =
          await prefs.setString('pwd_profile', jsonEncode(jsonResponse.first));
      if (result) {
        return true;
      }
      return false;
    } on DioError {
      return false;
    }
  }

  static createProfile(String name, String email, String password) async {
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

  static Future getPrefProfile() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('pwd_profile') != null) {
      String? userPref = prefs.getString('pwd_profile');
      Map profile = jsonDecode(userPref!);
      return profile;
    }

    var id = await User.getUserFromToken();
    var pwdProfile = await Pwd.getProfile(id);
    if (pwdProfile) {
      String? userPref = prefs.getString('pwd_profile');
      Map profile = jsonDecode(userPref!);
      return profile;
    }
  }

  static deletePwdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("pwd_profile") != null) {
      prefs.remove("pwd_profile");
    }
  }

  static Future getEduactionLevels() async {
    var url = "${Config.apiBaseUrl}/education_levels/";
    List<dynamic> jsonResponse = await Config.apiGetCall(url);
    return jsonResponse;
  }

  static Future getDisabilities() async {
    var url = "${Config.apiBaseUrl}/disability/";
    List<dynamic> jsonResponse = await Config.apiGetCall(url);
    return jsonResponse;
  }
}
