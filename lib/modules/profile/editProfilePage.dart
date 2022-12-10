import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;

import '../account_auth/utils/city_list.dart';
import 'showProfilePage.dart';

class User {
  String name = "";
  String username = "";
  String email = "";
  int age = 0;
  String gender = "";
  String city = "";
  // String address = "";
  String id = "";
  bool? is_regular;

  User({
    required this.name,
    required this.username,
    required this.email,
    required this.age,
    required this.gender,
    required this.city,
    // required this.address,
    required this.id,
    required this.is_regular,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      name: data["data"]["data"]["name"],
      username: data["data"]["data"]["username"],
      email: data["data"]["data"]["email"],
      age: data["data"]["data"]["age"],
      gender: data["data"]["data"]["gender"],
      city: data['data']['data']["city"],
      // address: data['data']['data']["address"],
      id: data["data"]["data"]["id"],
      is_regular: data["data"]["data"]["is_regular"],
    );
  }
}

bool isInRange(String str) {
  return (int.parse(str) >= 13) && (int.parse(str) <= 100);
}

class EditProfilePage extends StatefulWidget {
  final String id;
  EditProfilePage(this.id) : super(key: null);

  @override
  _EditProfilePage createState() => _EditProfilePage();
}

class _EditProfilePage extends State<EditProfilePage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  String gender = "";
  String city = "Aceh";

  String validasi_email = "valid";
  void createAlertDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Maaf atas ketidaknyamanannya"),
            content: Text("Email ini sudah digunakan User lain"),
            // actions: <Widget>[
            //   FlatButton(onPressed: Navigator.of(context).pop, child: Text("Close")),
            // ],
          );
        });
  }

  final _regEditFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 40),
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontFamily: 'Pacifico',
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Edit Your Account Here ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                  key: _regEditFormKey,
                  child: Container(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 250, 0.95),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: _controllerName,
                            decoration: InputDecoration(
                              labelText: 'Nama Lengkap',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 18,
                              ),
                              hintText: 'Masukkan Nama Anda',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Tidak Boleh Kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 250, 0.95),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: _controllerAge,
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 18,
                              ),
                              hintText: 'Masukkan Email Anda',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Tidak Boleh Kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 250, 0.95),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: _controllerAge,
                            decoration: InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 18,
                              ),
                              hintText: 'Masukkan Username Anda',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Username Tidak Boleh Kosong';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 250, 0.95),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: TextFormField(
                            controller: _controllerAge,
                            decoration: InputDecoration(
                              labelText: 'Umur',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 18,
                              ),
                              hintText: 'Masukkan Umur Anda',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Umur harus berupa angka!';
                              } else if (!isInRange(value)) {
                                return 'Umur di antara 13-100';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            const Text(
                              "Jenis Kelamin: ",
                              style: TextStyle(
                                fontSize: 15,
                              ),
                            ),
                            RadioListTile(
                                dense: true,
                                title: Text(
                                  "Pria",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                                ),
                                value: "Pria",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            RadioListTile(
                                dense: true,
                                title: Text(
                                  "Wanita",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                                ),
                                value: "Wanita",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                            RadioListTile(
                                dense: true,
                                title: Text(
                                  "Tidak Ingin Memberi Tahu",
                                  style: TextStyle(
                                    fontSize: 15,
                                    color: Color.fromRGBO(90, 90, 90, 1),
                                  ),
                                ),
                                value: "Tidak Memberi Tahu",
                                groupValue: gender,
                                onChanged: (value) {
                                  setState(() {
                                    gender = value.toString();
                                  });
                                }),
                          ],
                        ),
                        
                        SizedBox(height: 10),
                        Column(children: [
                          SizedBox(height: 0),
                          DropdownButtonFormField(
                            decoration: InputDecoration(
                              // filled: true,
                              labelText: 'Domisili',
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.green),
                              ),
                            ),
                            value: city,
                            icon: const Icon(Icons.keyboard_arrow_down),
                            items: listCity.map((String items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Text(items),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                city = newValue!;
                              });
                            },
                          ),
                        ]),
                        
                        SizedBox(height: 20),
                        Container(
                          padding: EdgeInsets.only(top: 3, left: 3),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              border: Border(
                                bottom: BorderSide(color: Colors.black),
                                top: BorderSide(color: Colors.black),
                                left: BorderSide(color: Colors.black),
                                right: BorderSide(color: Colors.black),
                              )),
                          child: MaterialButton(
                            minWidth: double.infinity,
                            height: 60,
                            onPressed: () async {
                              String id = widget.id;
                              print(id);
                              var URL =
                                  "https://wazzt.up.railway.app/for_profile/edit_profile/" +
                                      id +
                                      "/validate_email";
                              final Response = await http.post(
                                Uri.parse(URL),
                                headers: <String, String>{
                                  'Content-Type': 'application/json'
                                },
                                body: jsonEncode(<String, String>{
                                  'email': _controllerEmail.text,
                                }),
                              );
                              print(Response);
                              print(URL);
                              print(Response.body);
                              Map<String, dynamic> data =
                                  jsonDecode(Response.body);
                              print("hellow 1");
                              validasi_email = data['data']['validasi'];
                              print(validasi_email);
                              print("heellooww 2");
                              if (validasi_email != "terpakai") {
                                if (_regEditFormKey.currentState!.validate()) {
                                  print(id);
                                  var url =
                                      'https://wazzt.up.railway.app/for_profile/edit_profile/' +
                                          id +
                                          '/edit';
                                  print("ABC");
                                  final response = await http.post(
                                      Uri.parse(url),
                                      headers: <String, String>{
                                        'Content-Type': 'application/json'
                                      },
                                      body: jsonEncode(<String, String>{
                                        'name': _controllerName.text,
                                        'email': _controllerEmail.text,
                                        'username': _controllerUsername.text,
                                        'age': _controllerAge.text,
                                        'gender': gender,
                                        'city': city,
                                      }));
                                  print("tess");
                                  print(response);
                                  Map<String, dynamic> data =
                                      jsonDecode(response.body);
                                  print(data);

                                  // Navigator.of(context).push(
                                  //   MaterialPageRoute(
                                  //       builder: (context) =>
                                  //           ShowProfilePage(id)),
                                  // );
                                }
                              } else {
                                print(validasi_email);
                                createAlertDialog();
                              }
                            },
                            color: Color.fromARGB(255, 165, 223, 153),
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Text(
                              "Submit",
                              style: TextStyle(
                                fontFamily: 'Source Sans Pro',
                                fontWeight: FontWeight.w600,
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  )),
              // Container(
              //   padding: EdgeInsets.only(top: 3, left: 3),
              //   decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(50),
              //       border: Border(
              //         bottom: BorderSide(color: Colors.black),
              //         top: BorderSide(color: Colors.black),
              //         left: BorderSide(color: Colors.black),
              //         right: BorderSide(color: Colors.black),
              //       )),
              //   child: MaterialButton(
              //     minWidth: double.infinity,
              //     height: 60,
              //     onPressed: () {},
              //     color: Color.fromARGB(255, 165, 223, 153),
              //     elevation: 0,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(50),
              //     ),
              //     child: Text(
              //       "Submit",
              //       style: TextStyle(
              //         fontFamily: 'Source Sans Pro',
              //         fontWeight: FontWeight.w600,
              //         fontSize: 18,
              //         color: Colors.white,
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}

// // we will be creating a widget for text field
// Widget inputFile({label, obscureText = false}) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: <Widget>[
//       Text(
//         label,
//         style: TextStyle(
//             fontSize: 15, fontWeight: FontWeight.w400, color: Colors.black87),
//       ),
//       SizedBox(
//         height: 5,
//       ),
//       TextField(
//         obscureText: obscureText,
//         decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//               borderSide: BorderSide(color: Color.fromARGB(255, 165, 223, 153)),
//             ),
//             border: OutlineInputBorder(
//                 borderSide:
//                     BorderSide(color: Color.fromARGB(255, 165, 223, 153)))),
//       ),
//       SizedBox(
//         height: 10,
//       )
//     ],
//   );
// }
