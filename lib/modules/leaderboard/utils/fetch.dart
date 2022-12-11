import 'package:wazzt/modules/leaderboard/models/leaderboard_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Leaderboard>> fetchToDo() async {
  var url = Uri.parse('https://wazzt.up.railway.app/leaderboard/show_json_sorted/');
  var response = await http.get(
    url,
    headers: {
      "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));

  // melakukan konversi data json menjadi object WatchList
  List<Leaderboard> listUser = [];

  for (var d in data) {
    if (d != null) {
      listUser.add(Leaderboard.fromJson(d));
    }
  }
  return listUser;
}