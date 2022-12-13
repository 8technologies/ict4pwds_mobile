import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

class InformationBank {
  final int? id;
  final String? title;
  final String? coverImage;
  final String? description;
  // final String? eventCategory;
  final String? amount;
  final String? organiser;
  final String? categoryName;
  // final String? startDate;
  // final String? startTime;
  // final String? endDate;
  // final String? endTime;
  final String? eventUrl;

  InformationBank({
    this.id,
    this.coverImage,
    this.title,
    this.description,
    // this.eventCategory,
    this.amount,
    this.organiser,
    this.categoryName,
    // this.startDate,
    // this.startTime,
    // this.endDate,
    // this.endTime,
    this.eventUrl,
  });

  factory InformationBank.fromJson(Map<String, dynamic> json) {
    return InformationBank(
      id: json['id'],
      title: json['title'],
      coverImage: json['cover_image'],
      description: json['event_description'],
      // eventCategory: json['event_category'][0],
      amount: json['amount'],
      organiser: json['organizer'],
      categoryName: json['category_name'][0],
      // startDate: json['start_date'],
      // startTime: json['start_time'],
      // endDate: json['end_date'],
      // endTime: json['end_time'],
      eventUrl: json['event_url'],
    );
  }

  Future<List<InformationBank>> fetchData() async {
    var url = "${Config.apiBaseUrl}/InformationBank-and-events/events/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      List jsonResponse = response.data["results"];
      return jsonResponse.map((data) => InformationBank.fromJson(data)).toList();
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      List<InformationBank> returnedData = [];
      return returnedData;
    }
  }
}
