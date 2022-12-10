import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wazzt/modules/forum/models/forum_model.dart';

Future<List<Forum>> fetch() async {
  var url = Uri.parse('https://wazzt.up.railway.app/forum/json/');
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
  List<Forum> watch = [];
  for (var d in data) {
    if (d != null) {
      watch.add(Forum.fromJson(d));
    }
  }
  return watch;
}
