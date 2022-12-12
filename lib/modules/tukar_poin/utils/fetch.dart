import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazzt/modules/tukar_poin/models/voucher_model.dart';


Future<List<Voucher>> fetch() async {
  var url = Uri.parse('https://web-production-06f3.up.railway.app/tukarpoin/json/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object watch
  List<Voucher> watch = [];
  for (var d in data) {
    if (d != null) {
      watch.add(Voucher.fromJson(d));
    }
  }
  return watch;
}