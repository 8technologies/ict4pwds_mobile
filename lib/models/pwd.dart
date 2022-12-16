import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio_http_cache/dio_http_cache.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:ict4pwds_mobile/constants/helpers.dart';
import 'package:ict4pwds_mobile/constants/navigation_service.dart';
import 'package:ict4pwds_mobile/models/user.dart';
import 'package:ict4pwds_mobile/screens/auth/login.dart';
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

  static createProfile(String payload) async {
    var url = "${Config.apiBaseUrl}/persons_with_disabilities/persons/";
    var response = await Config.apiPostCall(url, payload);
    if (response['error']) {
      return "Error creating profile";
    }
    return "success";
  }

  static upDateProfile(String payload, int id) async {
    var url = "${Config.apiBaseUrl}/persons_with_disabilities/persons/$id/";
    var response = await Config.apiPutCall(url, payload);
    if (response['error']) {
      print(response['data']);
      return "Error creating profile";
    }
    return "success";
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

    Pwd.deletePwdToken();
    User.deleteUserToken();
    NavigationService().popToFirst(const Login());
  }

  static deletePwdToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString("pwd_profile") != null) {
      prefs.remove("pwd_profile");
    }
  }

  static Future getEduactionLevels() async {
    var url = "${Config.apiBaseUrl}/education_levels/";
    var response = await Config.apiGetCall(url);
    if (response['error']) {
      return [];
    }
    List<dynamic> jsonresp = response["data"];
    return jsonresp;
  }

  static Future getDisabilities() async {
    var url = "${Config.apiBaseUrl}/disability/";
    var response = await Config.apiGetCall(url);
    if (response['error']) {
      return [];
    }
    List<dynamic> jsonresp = response["data"];
    return jsonresp;
  }

  static Future getRegions() async {
    var url = "${Config.apiBaseUrl}/common/regions/";
    var response = await Config.apiGetCall(url);
    if (response['error']) {
      return [];
    }
    List<dynamic> jsonresp = response["data"];
    return jsonresp;
  }

  static Future getDistrict() async {
    var url = "${Config.apiBaseUrl}/districts/";
    var response = await Config.apiGetCall(url);
    if (response['error']) {
      return [];
    }
    List<dynamic> jsonresp = response["data"];
    return jsonresp;
  }
}
