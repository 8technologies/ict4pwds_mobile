import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

class Guidance {
  final int? id;
  final String? image;
  final String? centerName;
  final String? phoneNumber;
  final String? emailAdress;
  final String? location;
  final String? servicesOffered;
  final int? serviceFee;
  final String? category;
  final String? updated;
  final String? timestamp;

  Guidance(
      {this.id,
      this.image,
      this.centerName,
      this.phoneNumber,
      this.emailAdress,
      this.location,
      this.servicesOffered,
      this.serviceFee,
      this.category,
      this.updated,
      this.timestamp
    });

  factory Guidance.fromJson(Map<String, dynamic> json) {
    return Guidance(
        id: json['id'],
        image: json['logo'],
        centerName: json['center_name'],
        phoneNumber: json['phone_number'],
        emailAdress: json['email_address'],
        location: json['location'],
        servicesOffered: json['services_offered'],
        serviceFee: json['service_fee'],
        category: json['category_of_persons_with_disabilities']['name'],
        updated: json['updated'],
        timestamp: json['timestamp']
      );
  }

  Future<List<Guidance>> fetchData() async {
    var url = "${Config.apiBaseUrl}/guidance_and_counselings/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      List jsonResponse = response.data;
      return jsonResponse.map((data) => Guidance.fromJson(data)).toList();
    } on DioError {
      List<Guidance> returnedData = [];
      return returnedData;
    }
  }
}
