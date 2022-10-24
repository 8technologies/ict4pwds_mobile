import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

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
        opportunityTitle: json['opportunity_title'],
        nameOfProvider: json['name_of_provider'],
        description: json['description'],
        addressOfProvider: json['address_of_provider'],
        opportunityCategory: json['opportunity_category'],
        typeOfOffer: json['type_of_offer'],
        startDate: json['start_date'],
        deadlineDate: json['deadline_date']);
  }

  Future<List<Opportunity>> fetchData() async {
    var url = "${Config.apiBaseUrl}/opportunities/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      List jsonResponse = response.data;
      return jsonResponse.map((data) => Opportunity.fromJson(data)).toList();
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      List<Opportunity> returnedData = [];
      return returnedData;
    }
  }
}
