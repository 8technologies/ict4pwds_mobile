import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

class InformationBank {
  final int? id;
  final String? title;
  final String? description;
  final int? category;
  final String? publisher;
  final String? authors;
  final String? categoryName;
  final String? updated;
  final String? timestamp;
  final String? file;

  InformationBank({
    this.id,
    this.title,
    this.description,
    this.category,
    this.publisher,
    this.authors,
    this.categoryName,
    this.updated,
    this.timestamp,
    this.file,
  });

  factory InformationBank.fromJson(Map<String, dynamic> json) {
    return InformationBank(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: json['category'],
      publisher: json['publisher'],
      authors: json['authors'],
      categoryName: json['category_name'],
      updated: json['updated'],
      timestamp: json['timestamp'],
      file: json['file'],
    );
  }

  Future<List<InformationBank>> fetchData() async {
    var url = "${Config.apiBaseUrl}/information_banks/";
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
