import 'package:flutter/material.dart';
import 'package:flutter/src/material/colors.dart';

import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../account_auth/utils/city_list.dart';
import '../../account_auth/utils/cookie_request.dart';
import 'cobaShowBank.dart';

bool isInRange(String str) {
  return (int.parse(str) >= 13) && (int.parse(str) <= 100);
}

class EditBankPage extends StatefulWidget {
  final String id;
    EditBankPage(this.id) : super(key: null);

    @override
    _EditBankPage createState() => _EditBankPage();
  }

  class _EditBankPage extends State<EditBankPage> {
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();

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

  final _bankEditFormKey = GlobalKey<FormState>();


   @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
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
                  key: _bankEditFormKey,
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
                              labelText: 'Nama Institusi',
                              labelStyle: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Source Sans Pro',
                                fontSize: 18,
                              ),
                              hintText: 'Masukkan Nama Institusi',
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                              ),
                            ),
                            autovalidateMode: AutovalidateMode.onUserInteraction,
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
                            controller: _controllerEmail,
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
                            // autovalidateMode: AutovalidateMode.onUserInteraction,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email Tidak Boleh Kosong';
                              }
                              return null;
                            },
                          ),
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
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(250, 250, 250, 0.95),
                            borderRadius: BorderRadius.circular(5),
                           ),
                          child: TextFormField(
                            minLines: 3, // it works as the rows for the textarea)
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: _controllerAddress,
                            decoration: InputDecoration(
                              labelText: 'Alamat Lengkap',
                              labelStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 15,
                                  fontFamily: 'AvenirLight'),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                BorderSide(color: Colors.green),
                              ),
                              hintText: 'Alamat Lengkap',
                              prefixIcon: Icon(Icons.map_sharp),
                              hintStyle: TextStyle(
                                color: Color.fromRGBO(200, 200, 200, 1),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return "Username tidak boleh kosong";
                              }
                              return null;
                            },
                          ),
                        ),
                        
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
                                if (_bankEditFormKey.currentState!.validate()) {
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
                                        'city': city,
                                        'address': _controllerAddress.text,
                                      }));
                                  print("tess");
                                  print(response);
                                  Map<String, dynamic> data =
                                      jsonDecode(response.body);
                                  print(data);

                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            ShowBankPage(id)),
                                  );
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