// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

import 'dart:convert';

List<Leaderboard> LeaderboardFromJson(String str) => List<Leaderboard>.from(
    json.decode(str).map((x) => Leaderboard.fromJson(x)));

String LeaderboardToJson(List<Leaderboard> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Leaderboard {
  Leaderboard(
      {required this.pk,
      required this.name,
      required this.city,
      required this.address,
      required this.email});

  int pk;
  String name;
  String city;
  String address;
  String email;

  // void changeStatus() {
  //   this.watched = !this.watched;
  // }

  factory Leaderboard.fromJson(Map<String, dynamic> json) => Leaderboard(
        pk: json["pk"],
        name: json["fields"]["name"],
        city: json["fields"]["city"],
        address: json["fields"]["address"],
        email: json["fields"]["email"],
        //weight: json["fields"]["weight"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "city": city,
        "address": address,
        //"weight" : weight,
      };
}
