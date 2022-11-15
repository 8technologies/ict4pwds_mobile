import 'package:dio/dio.dart';
import 'package:ict4pwds_mobile/constants/config.dart';

class Game {
  final int? id;
  final String? gameName;
  final String? coverImage;
  final String? description;
  final String? playingGuidelines;
  final String? venue;
  final String? organiser;
  final String? dateOrganisedFrom;
  final String? dateOrganisedTo;
  final String? timeOrganisedFrom;
  final String? timeOrganisedTo;
  final String? updated;
  final String? timeStamp;

  Game(
      {this.id,
      this.coverImage,
      this.gameName,
      this.description,
      this.playingGuidelines,
      this.venue,
      this.organiser,
      this.dateOrganisedFrom,
      this.dateOrganisedTo,
      this.timeOrganisedFrom,
      this.timeOrganisedTo,
      this.updated,
      this.timeStamp});

  factory Game.fromJson(Map<String, dynamic> json) {
    return Game(
        id: json['id'],
        gameName: json['game_name'],
        coverImage: json['cover_image'],
        description: json['description'],
        playingGuidelines: json['playing_guidelines'],
        venue: json['venue'],
        organiser: json['organiser'],
        dateOrganisedFrom: json['date_organised_from'],
        dateOrganisedTo: json['date_organised_to'],
        timeOrganisedFrom: json['time_organised_from'],
        timeOrganisedTo: json['time_organised_to'],
        updated: json['updated'],
        timeStamp: json['timestamp']);
  }

  Future<List<Game>> fetchData() async {
    var url = "${Config.apiBaseUrl}/games_and_sports/games/";
    try {
      var token = await Config.getUserToken();
      var dio = Dio();
      dio.options.headers["Authorization"] = "Bearer $token";
      Response response = await dio.get(url);
      List jsonResponse = response.data["results"];
      return jsonResponse.map((data) => Game.fromJson(data)).toList();
    } on DioError catch (e) {
      // ignore: avoid_print
      print(e);
      List<Game> returnedData = [];
      return returnedData;
    }
  }
}
