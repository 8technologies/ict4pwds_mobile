import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

class UserNotification{
  final int? id;
  final String? category;
  final String? message;
  final String? status;

  UserNotification({this.id, this.category, this.message, this.status});

  factory UserNotification.fromJson(Map<String, dynamic> json) {
    return UserNotification(
        id: json['id'],
        category: json['UserNotification_title'],
        message: json['name_of_provider'],
        status: json['description']);
  }

  Future<List<UserNotification>> fetchData() async {
    var url = "${Config.apiBaseUrl}/opportunities/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      //List jsonResponse = response.data;
      List jsonResponse = [];
      return jsonResponse.map((data) => UserNotification.fromJson(data)).toList();
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      List<UserNotification> returnedData = [];
      return returnedData;
    }
  }
}
