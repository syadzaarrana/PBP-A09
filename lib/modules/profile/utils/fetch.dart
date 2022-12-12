import 'dart:convert';

import '../../account_auth/models/auth_models.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Future<User> fetchUser(String ID) async {
//   String id = ID;

//   var url = "https://wazzt.up.railway.app/for_profile/show_profile_flutter/" + id;
//   try {
//     final response = await http.get(Uri.parse(url));
//     print(response);
//     print("ABC");
//     print(response.body);
//     print(url);
//     ;
//     Map<String, dynamic> data = jsonDecode(response.body);
//     print("ABC");
//     print(data);

//     return User.fromJson(jsonDecode(response.body));
//   } catch (error) {
//     print("error");
//     rethrow;
//   }
// }

Future<User> fetchUser(int id) async {
  var url = Uri.parse(
      "http://wazzt.up.railway.app/for_profile/flutter/" + id.toString() + "/");
  // "https://wazzt.up.railway.app/for_profile/flutter/1"
  // "http://127.0.0.1:8000/for_profile/flutter/"
  var response = await http.get(
    url,
    headers: {
      // "Access-Control-Allow-Origin": "*",
      "Content-Type": "application/json",
      // "Access-Control-Allow-Headers" : "Origin, X-Requested-With, Content-Type, Accept, Authorization",
    },
  );
  print("masuk fetch");
  print(id);
  // print(response);

  var user = jsonDecode(utf8.decode(response.bodyBytes));
  // print('dibawah ini user:');
  // print(user);
  // print("tes bawah ini");
  // print(User.fromJson(user));
  // print("bawah ini kating");
  // print(jsonDecode(response.body));
  // print(User.fromJson(jsonDecode(response.body)));
  return User.fromJson(jsonDecode(response.body));
}

// Future<List<Donasi>> fetchHistory(int id) async {
//   // var url = Uri.parse('http://127.0.0.1:8000/sumbang/history/6/') ; for local
//   var url = Uri.parse('https://wazzt.up.railway.app/sumbang/history/' + id.toString() + "/") ;
//   print(url);
//   var response = await http.get(
//     url,
//     headers: {
//       "Content-Type": "application/json",
//     },
//   );

//   var data = jsonDecode(utf8.decode(response.bodyBytes));
//   print("abis ini data:");
//   print(data);

//   // melakukan konversi data json menjadi object Donasi
//   List<Donasi> daftarDonasi = [];
//   print("ini daftar donasi");
//   print(daftarDonasi);

//   for (var d in data) {
//     if (d != null) {
//       print("ini d:");
//       print(d);
//       daftarDonasi.add(Donasi.fromJson(d));
//     }
//   }

//   print("abis for loop print daftar donasi");
//   print(daftarDonasi);
//   return daftarDonasi;
// }

// Future<List<User>> fetchUser(int id) async {
//   var url = Uri.parse(
//       "http://127.0.0.1:8000/for_profile/flutter/" + id.toString() + "/");
//   var response = await http.get(
//     url,
//     headers: {
//       "Access-Control-Allow-Origin": "*",
//       "Content-Type": "application/json",
//     },
//   );
//   print("masuk fetch");
//   print(id);

//   var user = jsonDecode(utf8.decode(response.bodyBytes));

//   List<User> dataUser = [];
//   for (var i in user) {
//     if (i != null) {
//       dataUser.add(User.fromJson(i));
//     }
//   }
//   return dataUser;
// }
