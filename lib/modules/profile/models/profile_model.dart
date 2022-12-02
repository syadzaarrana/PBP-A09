// import 'dart:convert';
// import 'dart:async';
// import 'dart:core';
// import 'package:http/http.dart' as http;

// class User {
//   String name = "";
//   String username = "";
//   String email = "";
//   String age = "";
//   String gender = "";
//   String city = "";
//   String address = "";
  
//   User({
//     required this.name,
//     required this.username,
//     required this.email,
//     required this.age,
//     required this.gender,
//     required this.city,
//     required this.address,
//   });

//   factory User.fromJson(Map<String, dynamic> data) {
//     return User(
//       name: data["data"]["data"]["name"],
//       username: data["data"]["data"]["username"],
//       email: data["data"]["data"]["email"],
//       age: data["data"]["data"]["age"],
//       gender: data["data"]["data"]["gender"],
//       city: data['data']['data']["city"],
//       address: data['data']['data']["address"],
//     );
//   }
// }
