import 'dart:convert';

List<Voucher> vocherFromJson(String str) =>
  List<Voucher>.from(json.decode(str).map((x) => Voucher.fromJson(x)));

String VoucherToJson(List<Voucher> data) =>
  json.encode(List<dynamic>.from(data.map((x) => x.toJson())));


class Voucher {
  String model;
  int pk;
  Fields fields;

  Voucher({
    required this.model,
    required this.pk,
    required this.fields,
  });

  factory Voucher.fromJson(Map<String, dynamic> json) => Voucher(
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
    required this.voucherTitle,
    required this.voucherDesc,
    required this.requiredPoin,
    required this.requiredArea,
    required this.voucherMount,
    required this.availableTill,
  });

  String voucherTitle;
  String voucherDesc;
  int requiredPoin;
  String requiredArea;
  int voucherMount;
  DateTime availableTill;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        voucherTitle: json["voucherTitle"],
        voucherDesc: json["voucherDesc"],
        requiredPoin: json["requiredPoin"],
        requiredArea: json["requiredArea"],
        voucherMount: json["voucherMount"],
        availableTill: json["availableTill"],
      );

  Map<String, dynamic> toJson() => {
        "voucherTitle": voucherTitle,
        "voucherDesc": voucherDesc,
        "requiredPoin": requiredPoin,
        "requiredArea": requiredArea,
        "voucherMount": voucherMount,
        "availableTill": availableTill,
      };
}
