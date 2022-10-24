import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Opportunity {
  final int? id;
  final String? opportunityTitle;
  final String? nameOfProvider;
  final String? description;
  final String? addressOfProvider;
  final int? opportunityCategory;
  final String? typeOfOffer;
  final String? startDate;
  final String? deadlineDate;

  Opportunity(
      {this.id,
      this.opportunityTitle,
      this.nameOfProvider,
      this.description,
      this.addressOfProvider,
      this.opportunityCategory,
      this.typeOfOffer,
      this.startDate,
      this.deadlineDate});

  factory Opportunity.fromJson(Map<String, dynamic> json) {
    return Opportunity(
        id: json['id'],
        opportunityTitle: json['opportunityTitle'],
        nameOfProvider: json['nameOfProvider'],
        description: json['description'],
        addressOfProvider: json['addressOfProvider'],
        opportunityCategory: json['opportunityCategory'],
        typeOfOffer: json['typeOfOffer'],
        startDate: json['startDate'],
        deadlineDate: json['deadlineDate']);
  }

  Future<List<Opportunity>> fetchData() async {
    var url = "${Config.apiBaseUrl}/accounts/login";
    try {
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer";
      Response response = await dio.get(url);
      List jsonResponse = json.decode(response.data);
      return jsonResponse.map((data) => Opportunity.fromJson(data)).toList();
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      List<Opportunity> returnedData = [];
      return returnedData;
    }
  }
}
