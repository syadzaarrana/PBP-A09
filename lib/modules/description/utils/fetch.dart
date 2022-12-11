import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazzt/modules/description/models/description_model.dart';

Future<List<Description>> fetchDescription(int id) async {
  var url = Uri.parse('https://wazzt.up.railway.app/descriptions/flutterjson/');
  var response = await http.get(
    url,
    headers: {
      // "Access-Control-Allow-Origin": "*", // Required for CORS support to work
      // "Access-Control-Allow-Credentials":
      //     "true", // Required for cookies, authorization headers with HTTPS
      // "Access-Control-Allow-Headers":
      //     "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
      // "Access-Control-Allow-Methods": "POST, OPTIONS, GET",
      "Content-Type": "application/json",
    },
  );

  // melakukan decode response menjadi bentuk json
  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object Watchlist
  List<Description> listDescription = [];
  for (var d in data) {
    if (d != null) {
      Description desc = Description.fromJson(d);
      if (desc.wasteBankId == id) {
        listDescription.add(desc);
      }
    }
  }

  return listDescription;
}
