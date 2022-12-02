import 'dart:convert';
import 'dart:core';

class User {
  String? username = "";
  String? email = "";
  String? name = "";
  int? age = 0;
  String? gender = "";
  String? city = "";
  String? address = "";
  int? score;
  int? weight;

  bool? is_regular;
  bool? is_bank;
  bool? is_superuser;

  User({
    this.username,
    this.email,
    this.name,
    this.age,
    this.gender,
    this.city,
    this.address,
    this.score,
    this.weight,

    this.is_regular,
    this.is_bank,
    this.is_superuser,

  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
        username: data["data"]["data"]["username"],
        email: data["data"]["data"]["email"],
        name: data["data"]["data"]["name"],
        age: data["data"]["data"]["age"],
        gender: data["data"]["data"]["gender"],
        city: data["data"]["data"]["city"],
        address: data["data"]["data"]["address"],
        score: data["data"]["data"]["score"],
        weight: data["data"]["data"]["weight"],
        is_regular: data["data"]["data"]["is_regular"],
        is_bank: data["data"]["data"]["is_bank"],
        is_superuser: data["data"]["data"]["is_superuser"]);
  }
}

// factory User.fromJson(Map<String, dynamic> map) {
//     return User(
//         map['data']['email'],
//         map['data']['username'],
//         map['data']['nama'],
//         map['data']['jenis_kelamin'],
//         map['data']['institusi'],
//         map['data']['kontak']
//     );
//   }
//
//   String toJson() => json.encode(toMap());
//
//   @override
//   String toString() {
//     return 'User(email: $email, username: $username, nama: $nama, jenis_kelamin: $jenis_kelamin, intitusi: $institusi, kontak: $kontak)';
//   }
// }
