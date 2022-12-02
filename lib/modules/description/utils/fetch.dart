import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazzt/modules/description/models/description_model.dart';

Future<List<Description>> fetchDescription() async {
  var url = Uri.parse('https://wazzt.up.railway.app/descriptions/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Watchlist
  List<Description> listDescription = [];
  for (var d in data) {
    if (d != null) {
      listDescription.add(Description.fromJson(d));
    }
  }

  return listDescription;
}
