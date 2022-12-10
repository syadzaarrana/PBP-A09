import 'package:flutter/material.dart';
import 'dart:core';
import 'package:provider/provider.dart';

import '../utils/city_list.dart';
import '../utils/cookie_request.dart';
import 'login_page.dart';
import 'package:flutter/services.dart';

bool isInRange(String str) {
  return (int.parse(str) >= 13) && (int.parse(str) <= 100);
}

class SignupRegPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignupRegPage> {
  final _signupRegFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerUsername = TextEditingController();
  final TextEditingController _controllerPassword1 = TextEditingController();
  final TextEditingController _controllerPassword2 = TextEditingController();
  final TextEditingController _controllerAge = TextEditingController();

  String? gender;

  String city = "Aceh";

  bool isPasswordVisible = false;
  void togglePasswordView() {
    setState(() {
      isPasswordVisible = !isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up Page'),
        ),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                    child: const Text(
                      'Buat akun',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: const Text(
                      'untuk masyarakat umum',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                ),
                Form(
                    key: _signupRegFormKey,
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
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  border: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.lightGreen),
                                  ),
                                  hintText: 'Nama Lengkap',
                                  prefixIcon: Icon(Icons.account_circle),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Nama tidak boleh kosong";
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
                                    borderSide:
                                    BorderSide(color: Colors.green),
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
                                    return "Email tidak boleh kosong";
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
                                controller: _controllerUsername,
                                decoration: InputDecoration(
                                  labelText: 'Username',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Username',
                                  prefixIcon: Icon(Icons.alternate_email),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Username tidak boleh kosong";
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
                                controller: _controllerPassword1,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    splashRadius: 1,
                                    icon: Icon(isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePasswordView,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password tidak boleh kosong";
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
                                controller: _controllerPassword2,
                                obscureText: !isPasswordVisible,
                                decoration: InputDecoration(
                                  labelText: 'Konfirmasi Password',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Konfirmasi Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    splashRadius: 1,
                                    icon: Icon(isPasswordVisible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePasswordView,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password tidak boleh kosong";
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
                                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                                 keyboardType: TextInputType.number,
                                controller: _controllerAge,
                                decoration: InputDecoration(
                                  labelText: 'Umur',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Umur',
                                  prefixIcon: Icon(Icons.group),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Umur harus berupa angka!";
                                  }
                                  else if (!isInRange(value) ){
                                    return 'Umur di antara 13-100';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            // inputFormatters: [WhitelistingTextInputFormatter.digitsOnly],
                            //  keyboardType: TextInputType.number,
                            SizedBox(height: 20),
                            Column(
                              children: [
                                const Text("Jenis Kelamin: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                  ),),
                                RadioListTile(
                                  dense: true,
                                  title: Text("Pria",
                                      style: TextStyle(
                                        fontSize: 15,
                                        color: Color.fromRGBO(90,90,90,1),
                                      ),
                                  ),
                                  value: "Pria",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                ),
                                RadioListTile(
                                  dense: true,
                                  title: Text("Wanita",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(90,90,90,1),
                                    ),
                                  ),
                                  value: "Wanita",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                ),
                                RadioListTile(
                                  title: Text("Tidak ingin memberi tahu",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: Color.fromRGBO(90,90,90,1),
                                    ),
                                  ),
                                  value: "Tidak memberi tahu",
                                  groupValue: gender,
                                  onChanged: (value) {
                                    setState(() {
                                      gender = value.toString();
                                    });
                                  },
                                )
                              ],
                            ),
                            SizedBox(height: 10),
                            Column(
                              children: [
                                // ListTile(
                                //   leading: const Icon(Icons.class_),
                                //   title: const Text(
                                //     'Domisili',
                                //   )
                                // ),
                                SizedBox(height: 0),
                                DropdownButtonFormField(
                                  hint: Text('Domisili'),
                                  decoration: InputDecoration(
                                    // filled: true,
                                    labelText: 'Domisili',
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
                                    if (_signupRegFormKey.currentState!
                                        .validate()) {

                                      // Untuk local host Chrome
                                      // const url = "http://127.0.0.1:8000/authentication/signup_reg/";

                                      // Untuk local host Android Emulator
                                      // const url = "http://10.0.2.2:8000/authentication/signup_reg/";

                                      const url = "https://wazzt.up.railway.app/authentication/signup_reg/";



                                      final response =
                                          await request.signup(url, {
                                            'name' : _controllerName.text,
                                            'email': _controllerEmail.text,
                                            'username': _controllerUsername.text,
                                            'password1': _controllerPassword1.text,
                                            'password2': _controllerPassword2.text,
                                            // 'age': int.parse(_controllerAge.text),
                                            'age': _controllerAge.text,
                                            'gender' : gender,
                                            'city' : city,
                                          });

                                      if (request.signedUp) {
                                        print("udah sign up nih");
                                        _signupRegFormKey.currentState?.reset();
                                        showAlertDialog2(context);
                                      } else {
                                        print("blm sign up nih");
                                        print(request.message);
                                        showAlertDialog(context, request.message);
                                      }
                                    } else {
                                      print("tidak valid");
                                    }


                                  },
                                  child: Text("Sign Up"),
                                ))
                          ],
                        ))),
                Row(
                  children: <Widget>[
                    const Text('Sudah punya akun?'),
                    TextButton(
                      child: const Text(
                        'Login di sini',
                      ),
                      onPressed: () {
                        //signup screen
                        // Navigator.pop(context);
                        // Navigator.pop(context);
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginPage(),
                            ));
                      },
                    ),
                  ],
                  mainAxisAlignment: MainAxisAlignment.center,
                )
              ],
            )));
  }
}

showAlertDialog(BuildContext context, String warning) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Coba Lagi"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text(warning),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

showAlertDialog2(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Close"),
    onPressed: () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Anda berhasil sign up!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
