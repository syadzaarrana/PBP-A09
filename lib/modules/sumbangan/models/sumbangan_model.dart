import 'dart:convert';

// To parse this JSON data, do
//
//     final todo = todoFromJson(jsonString);

List<Donasi> DonasiFromJson(String str) =>
    List<Donasi>.from(json.decode(str).map((x) => Donasi.fromJson(x)));

String DonasiToJson(List<Donasi> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Donasi {
  dynamic donatur;
  dynamic date;
  dynamic jenis;
  dynamic berat;
  dynamic poin;
  dynamic bank_sampah;


  Donasi({
    required this.donatur,
    required this.date,
    required this.jenis,
    required this.berat,
    required this.poin,
    required this.bank_sampah,
  });

  factory Donasi.fromJson(Map<String, dynamic> json) => Donasi(
      donatur: json["fields"]["donatur"],
      date: json["fields"]["date"],
      jenis: json["fields"]["jenis"],
      berat: json["fields"]["berat"],
      poin: json["fields"]["poin"],
      bank_sampah: json["fields"]["bank_sampah"],
    );

  Map<String, dynamic> toJson() => {
    'donatur': donatur,
    'date': date,
    'jenis': jenis,
    'berat': berat,
    'poin': poin,
    'bank_sampah': bank_sampah,
  };
}
