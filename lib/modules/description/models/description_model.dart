// To parse this JSON data, do
//
//     final description = descriptionFromJson(jsonString);

import 'dart:convert';

List<Description> descriptionFromJson(String str) => List<Description>.from(
    json.decode(str).map((x) => Description.fromJson(x)));

String descriptionToJson(List<Description> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Description {
  Description({
    required this.id,
    required this.wasteBankId,
    required this.title,
    required this.date,
    required this.image,
    required this.description,
  });

  int id;
  int wasteBankId;
  String title;
  DateTime date;
  String image;
  String description;

  factory Description.fromJson(Map<String, dynamic> json) => Description(
        id: json["id"],
        wasteBankId: json["waste_bank_id"],
        title: json["title"],
        date: DateTime.parse(json["date"]),
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "waste_bank_id": wasteBankId,
        "title": title,
        "date":
            "${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}",
        "image": image,
        "description": description,
      };
}
