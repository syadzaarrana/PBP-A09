// To parse this JSON data, do
//
//     final forum = forumFromJson(jsonString);

import 'dart:convert';

List<Forum> forumFromJson(String str) =>
    List<Forum>.from(json.decode(str).map((x) => Forum.fromJson(x)));

String forumToJson(List<Forum> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Forum {
  Forum({
    required this.model,
    required this.pk,
    required this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory Forum.fromJson(Map<String, dynamic> json) => Forum(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    required this.author,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  int author;
  String title;
  String body;
  DateTime createdAt;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        author: json["author"],
        title: json["title"],
        body: json["body"],
        createdAt: DateTime.parse(json["created_at"]),
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "title": title,
        "body": body,
        "created_at": createdAt.toIso8601String(),
      };
}
