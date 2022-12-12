import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/material/colors.dart';

import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../../widget/Drawer.dart';
import '../../account_auth/utils/city_list.dart';
import '../../account_auth/utils/cookie_request.dart';
import 'cobaShowBank.dart';
import 'showProfilePage.dart';

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

  final _bankEditFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    int idPemilik = request.id;
    return Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: const Text('Edit Profile'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                CircleAvatar(
                radius:50.0,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset('assets/img/bank_icon.png')),
                ),
                SizedBox(height:20),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: const Text(
                      'Edit Profile',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 30,
                          fontFamily: 'Pacifico'),
                    )),
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: const Text(
                      'Edit Your Account Here',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 15),
                    )),
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
                                  labelText: 'Institute Name',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.lightGreen),
                                  ),
                                  hintText: 'Institute Name',
                                  prefixIcon: Icon(Icons.account_circle),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Institute Name can not be blank!";
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
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email can not be blank!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            
                            SizedBox(height: 10),
                            Column(
                                children: [
                                  SizedBox(height: 0),
                                  DropdownButtonFormField(
                                    decoration: InputDecoration(
                                      // filled: true,
                                      labelText: 'Domicile',
                                      labelStyle: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 15,
                                          fontFamily: 'AvenirLight'),
                                      focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                        BorderSide(color: Colors.green),
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
                                ]
                            ),
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
                                  labelText: 'Full Address',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Full Address',
                                  prefixIcon: Icon(Icons.map_sharp),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Address can not be blank";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 20),
                            Container(
                                width: double.infinity,
                                child: TextButton(
                                  style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.green),
                                    foregroundColor:
                                        MaterialStateProperty.all<Color>(
                                            Colors.white),
                                  ),
                                  onPressed: () async {
                                    if (_bankEditFormKey.currentState!
                                        .validate()) {
                                      _bankEditFormKey.currentState!.save();
                                      final response = await http.post(
                                          Uri.parse(
                                              "https://wazzt.up.railway.app/for_profile/edit_bank_flutter/" +
                                                  idPemilik.toString() + "/"),
                                          headers: <String, String>{
                                            "Access-Control-Allow-Origin": "*",
                                            'Content-Type':
                                                'application/json; charset=UTF-8',
                                          },
                                          body: jsonEncode(<String, dynamic>{
                                            'name': _controllerName.text,
                                            'email': _controllerEmail.text,
                                            'city': city,
                                            'address':_controllerAddress.text,
                                          }));
                                      print(response.body);
                                      Map<String, dynamic> data =
                                          jsonDecode(response.body);
                                      print(data);

                                      Navigator.of(context).push(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ShowBankPage(
                                                    idPemilik.toString())),
                                      );
                                    };
                                  },
                                  child: Text("Submit"),
                                )),
                                SizedBox(height: 20),
                                Container(
                                    width: double.infinity,
                                    child: TextButton(
                                      style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.green),
                                        foregroundColor:
                                            MaterialStateProperty.all<Color>(
                                                Colors.white),
                                      ),
                                      onPressed: () async {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ShowBankPage(
                                                        idPemilik.toString())),
                                          );
                                      },
                                      child: Text("Back"),
                                    ))
                          ],
                        ))),
              ],
            )));
  }
}







  

  // Future<void> submit(BuildContext context, int idPemilik) async {
  //   final response = await http.post(
  //       Uri.parse("https://wazzt.up.railway.app/for_profile/edit_reg_flutter" +
  //           idPemilik.toString()),
  //       // "http://127.0.0.1:8000/for_profile/edit_reg_flutter"
  //       // "https://wazzt.up.railway.app/for_profile/edit_reg_flutter"

  //       headers: <String, String>{'Content-Type': 'application/json'},
  //       // headers: {
  //       // "Access-Control-Allow-Origin": "*",
  //       // "Content-Type": "application/json",
  //       // "Access-Control-Allow-Headers" : "Origin, X-Requested-With, Content-Type, Accept, Authorization",
  //       // },
  //       body: jsonEncode(<String, dynamic>{
  //         'name': _controllerName.text,
  //         'username': _controllerUsername.text,
  //         'email': _controllerEmail.text,
  //         'age': _controllerAge.text,
  //         'gender': gender,
  //         'city': city,
  //       }));
  //   print("body: " + response.body);
  //   print("bawah headers");
  //   print(response.headers);
  //   print("---------");
  // }

//   @override
//   Widget build(BuildContext context) {
//     final request = context.watch<CookieRequest>();
//     int idPemilik = request.id;
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         elevation: 0,
//         brightness: Brightness.light,
//         backgroundColor: Colors.white,
//         leading: IconButton(
//           onPressed: () {
//             Navigator.pop(context);
//           },
//           icon: Icon(
//             Icons.arrow_back_ios,
//             size: 20,
//             color: Colors.black,
//           ),
//         ),
//       ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         child: Container(
//           padding: EdgeInsets.symmetric(horizontal: 40),
//           height: MediaQuery.of(context).size.height - 50,
//           width: double.infinity,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   Text(
//                     "Edit Profile",
//                     style: TextStyle(
//                       fontFamily: 'Pacifico',
//                       fontSize: 30,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   Text(
//                     "Edit Your Account Here ",
//                     style: TextStyle(fontSize: 15, color: Colors.grey[700]),
//                   )
//                 ],
//               ),
//               Form(
//                   key: _regEditFormKey,
//                   child: Container(
//                     padding: EdgeInsets.all(15),
//                     child: Column(
//                       children: [
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(250, 250, 250, 0.95),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: TextFormField(
//                             controller: _controllerName,
//                             decoration: InputDecoration(
//                               labelText: 'Nama Lengkap',
//                               labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 18,
//                               ),
//                               hintText: 'Masukkan Nama Anda',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(250, 250, 250, 0.95),
//                               ),
//                             ),
//                             autovalidateMode:
//                                 AutovalidateMode.onUserInteraction,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Tidak Boleh Kosong';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(250, 250, 250, 0.95),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: TextFormField(
//                             controller: _controllerEmail,
//                             decoration: InputDecoration(
//                               labelText: 'Email',
//                               labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 18,
//                               ),
//                               hintText: 'Masukkan Email Anda',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(250, 250, 250, 0.95),
//                               ),
//                             ),
//                             autovalidateMode: AutovalidateMode.onUserInteraction,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Email Tidak Boleh Kosong';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(250, 250, 250, 0.95),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: TextFormField(
//                             controller: _controllerUsername,
//                             decoration: InputDecoration(
//                               labelText: 'Username',
//                               labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 18,
//                               ),
//                               hintText: 'Masukkan Username Anda',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(250, 250, 250, 0.95),
//                               ),
//                             ),
//                             autovalidateMode: AutovalidateMode.onUserInteraction,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Username Tidak Boleh Kosong';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Container(
//                           decoration: BoxDecoration(
//                             color: Color.fromRGBO(250, 250, 250, 0.95),
//                             borderRadius: BorderRadius.circular(5),
//                           ),
//                           child: TextFormField(
//                             controller: _controllerAge,
//                             decoration: InputDecoration(
//                               labelText: 'Umur',
//                               labelStyle: TextStyle(
//                                 color: Colors.grey,
//                                 fontFamily: 'Source Sans Pro',
//                                 fontSize: 18,
//                               ),
//                               hintText: 'Masukkan Umur Anda',
//                               hintStyle: TextStyle(
//                                 color: Color.fromRGBO(250, 250, 250, 0.95),
//                               ),
//                             ),
//                             autovalidateMode: AutovalidateMode.onUserInteraction,
//                             validator: (value) {
//                               if (value == null || value.isEmpty) {
//                                 return 'Umur harus berupa angka!';
//                               } else if (!isInRange(value)) {
//                                 return 'Umur di antara 13-100';
//                               }
//                               return null;
//                             },
//                           ),
//                         ),
//                         SizedBox(height: 10),
//                         Column(
//                           children: [
//                             const Text(
//                               "Jenis Kelamin: ",
//                               style: TextStyle(
//                                 fontSize: 15,
//                               ),
//                             ),
//                             RadioListTile(
//                                 dense: true,
//                                 title: Text(
//                                   "Pria",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color.fromRGBO(90, 90, 90, 1),
//                                   ),
//                                 ),
//                                 value: "Pria",
//                                 groupValue: gender,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     gender = value.toString();
//                                   });
//                                 }),
//                             RadioListTile(
//                                 dense: true,
//                                 title: Text(
//                                   "Wanita",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color.fromRGBO(90, 90, 90, 1),
//                                   ),
//                                 ),
//                                 value: "Wanita",
//                                 groupValue: gender,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     gender = value.toString();
//                                   });
//                                 }),
//                             RadioListTile(
//                                 dense: true,
//                                 title: Text(
//                                   "Tidak Ingin Memberi Tahu",
//                                   style: TextStyle(
//                                     fontSize: 15,
//                                     color: Color.fromRGBO(90, 90, 90, 1),
//                                   ),
//                                 ),
//                                 value: "Tidak Memberi Tahu",
//                                 groupValue: gender,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     gender = value.toString();
//                                   });
//                                 }),
//                           ],
//                         ),
//                         SizedBox(height: 10),
//                         Column(children: [
//                           SizedBox(height: 0),
//                           DropdownButtonFormField(
//                             isExpanded: true,
//                             decoration: InputDecoration(
//                               // filled: true,
//                               labelText: 'Domisili',
//                               labelStyle: TextStyle(
//                                   color: Colors.grey,
//                                   fontSize: 15,
//                                   fontFamily: 'AvenirLight'),
//                               focusedBorder: UnderlineInputBorder(
//                                 borderSide: BorderSide(color: Colors.green),
//                               ),
//                             ),
//                             value: city,
//                             icon: const Icon(Icons.keyboard_arrow_down),
//                             items: listCity.map((String items) {
//                               return DropdownMenuItem(
//                                 value: items,
//                                 child: Text(items),
//                               );
//                             }).toList(),
//                             onChanged: (String? newValue) {
//                               setState(() {
//                                 city = newValue!;
//                               });
//                             },
//                           ),
//                         ]),
//                         SizedBox(height: 20),
//                         Container(
//                           padding: EdgeInsets.only(top: 3, left: 3),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               border: Border(
//                                 bottom: BorderSide(color: Colors.black),
//                                 top: BorderSide(color: Colors.black),
//                                 left: BorderSide(color: Colors.black),
//                                 right: BorderSide(color: Colors.black),
//                               )),
//                           child: MaterialButton(
//                             minWidth: double.infinity,
//                             height: 60,
//                             onPressed: () async {
//                               if (_regEditFormKey.currentState!.validate()) {
//                                 _regEditFormKey.currentState!.save();
//                                 final response = await http.post(
//                                     Uri.parse(
//                                         "http://127.0.0.1:8000/for_profile/edit_reg_flutter" +
//                                             idPemilik.toString()),
//                                     headers: <String, String>{
//                                       'Content-Type':
//                                           'application/json; charset=UTF-8',
//                                     },
//                                     body: jsonEncode(<String, dynamic>{
//                                       'name': _controllerName.text,
//                                       'username': _controllerUsername.text,
//                                       'email': _controllerEmail.text,
//                                       'age': _controllerAge.text,
//                                       'gender': gender,
//                                       'city': city,
//                                     }));
//                                 Map<String, dynamic> data =
//                                     jsonDecode(response.body);
//                                 print(data);

//                                 Navigator.of(context).push(
//                                   MaterialPageRoute(
//                                       builder: (context) => ShowProfilePage(
//                                           idPemilik.toString())),
//                                 );
//                               }

//                               // submit(context, idPemilik);
//                               // print("edit submitted");
//                               // if (_regEditFormKey.currentState?.validate() ??
//                               //     true) {
//                               // submit(context, idPemilik);
//                               //   print("valid");
//                               // } else {
//                               //   print("tidak valid");
//                               // }
//                             },
//                             color: Color.fromARGB(255, 165, 223, 153),
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50),
//                             ),
//                             child: Text(
//                               "Submit",
//                               style: TextStyle(
//                                 fontFamily: 'Source Sans Pro',
//                                 fontWeight: FontWeight.w600,
//                                 fontSize: 18,
//                                 color: Colors.white,
//                               ),
//                             ),
//                           ),
//                         )
//                       ],
//                     ),
//                   )),
//               // Container(
//               //   padding: EdgeInsets.only(top: 3, left: 3),
//               //   decoration: BoxDecoration(
//               //       borderRadius: BorderRadius.circular(50),
//               //       border: Border(
//               //         bottom: BorderSide(color: Colors.black),
//               //         top: BorderSide(color: Colors.black),
//               //         left: BorderSide(color: Colors.black),
//               //         right: BorderSide(color: Colors.black),
//               //       )),
//               //   child: MaterialButton(
//               //     minWidth: double.infinity,
//               //     height: 60,
//               //     onPressed: () {},
//               //     color: Color.fromARGB(255, 165, 223, 153),
//               //     elevation: 0,
//               //     shape: RoundedRectangleBorder(
//               //       borderRadius: BorderRadius.circular(50),
//               //     ),
//               //     child: Text(
//               //       "Submit",
//               //       style: TextStyle(
//               //         fontFamily: 'Source Sans Pro',
//               //         fontWeight: FontWeight.w600,
//               //         fontSize: 18,
//               //         color: Colors.white,
//               //       ),
//               //     ),
//               //   ),
//               // ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

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
