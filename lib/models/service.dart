import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

class Service {
  final int? id;
  final int? serviceProvider;
  final String? serviceProviderNames;
  final String? name;
  final String? serviceType;
  final String? serviceFee;
  final String? description;

  Service(
      {this.id,
      this.serviceProvider,
      this.serviceProviderNames,
      this.name,
      this.serviceType,
      this.serviceFee,
      this.description});

  factory Service.fromJson(Map<String, dynamic> json) {
    return Service(
        id: json['id'],
        serviceProvider: json['service_provider'],
        serviceProviderNames: json['service_provider_names'],
        name: json['name'],
        serviceType: json['service_type'],
        serviceFee: json['service_fee'],
        description: json['description']);
  }

  Future<List<Service>> fetchData() async {
    var url = "${Config.apiBaseUrl}/sps/services/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      List jsonResponse = response.data["results"];
      return jsonResponse.map((data) => Service.fromJson(data)).toList();
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      List<Service> returnedData = [];
      return returnedData;
    }
  }
}
