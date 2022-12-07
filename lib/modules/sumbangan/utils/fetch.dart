import 'package:wazzt/modules/sumbangan/models/sumbangan_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Donasi>> fetchHistory(int id) async {
  var url = Uri.parse('https://wazzt.up.railway.app/sumbang/history/' + id.toString() + "/") ;
  print(url);
  var response = await http.get(
    url,
    headers: {
      "Content-Type": "application/json",
    },
  );

  var data = jsonDecode(utf8.decode(response.bodyBytes));
  print("abis ini data:");
  print(data);

  // melakukan konversi data json menjadi object Donasi
  List<Donasi> daftarDonasi = [];
  print("ini daftar donasi");
  print(daftarDonasi);

  for (var d in data) {
    if (d != null) {
      print("ini d:");
      print(d);
      daftarDonasi.add(Donasi.fromJson(d));
    }
  }

  print("abis for loop print daftar donasi");
  print(daftarDonasi);
  return daftarDonasi;
}