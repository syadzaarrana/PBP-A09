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

class SignupBankPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignupBankPage> {
  final _signupBankFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerName = TextEditingController();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword1 = TextEditingController();
  final TextEditingController _controllerPassword2 = TextEditingController();
  final TextEditingController _controllerAddress = TextEditingController();


  String city = "Aceh";

  bool isPassword1Visible = false;
  void togglePassword1View() {
    setState(() {
      isPassword1Visible = !isPassword1Visible;
    });
  }

  bool isPassword2Visible = false;
  void togglePassword2View() {
    setState(() {
      isPassword2Visible = !isPassword2Visible;
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
                      'Create account',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 22),
                    )),
                Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                    child: const Text(
                      'for Waste Bank',
                      style: TextStyle(
                          color: Colors.grey,
                          fontWeight: FontWeight.w500,
                          fontSize: 18),
                    )
                ),
                Form(
                    key: _signupBankFormKey,
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
                                  labelText: 'Institution Name',
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
                                  hintText: 'Institution Name',
                                  prefixIcon: Icon(Icons.account_circle),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Name can not be blank!";
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
                                    return "Email can not be blank!";
                                  }
                                  return null;
                                },
                              ),
                            ),
                            SizedBox(height: 10),

                            SizedBox(height: 10),
                            Container(
                              decoration: BoxDecoration(
                                color: Color.fromRGBO(250, 250, 250, 0.95),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: TextFormField(
                                controller: _controllerPassword1,
                                obscureText: !isPassword1Visible,
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
                                    icon: Icon(isPassword1Visible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword1View,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password can not be blank!";
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
                                obscureText: !isPassword2Visible,
                                decoration: InputDecoration(
                                  labelText: 'Confirm Password',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Confirm Password',
                                  prefixIcon: Icon(Icons.lock),
                                  suffixIcon: IconButton(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                    splashRadius: 1,
                                    icon: Icon(isPassword2Visible
                                        ? Icons.visibility_outlined
                                        : Icons.visibility_off_outlined),
                                    onPressed: togglePassword2View,
                                  ),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password can not be blank!";
                                  }
                                  return null;
                                },
                              ),
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
                                    return "Address can not be blank!";
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
                                    if (_signupBankFormKey.currentState!
                                        .validate()) {
                                      // Untuk local host Chrome
                                      // const url = "http://127.0.0.1:8000/authentication/signup_bank/";

                                      // Untuk local host Android Emulator
                                      // const url = "http://10.0.2.2:8000/authentication/signup_bank/";

                                      const url = "https://wazzt.up.railway.app/authentication/signup_bank/";

                                      final response =
                                      await request.signup(url, {
                                        'name' : _controllerName.text,
                                        'email': _controllerEmail.text,
                                        'password1': _controllerPassword1.text,
                                        'password2': _controllerPassword2.text,
                                        'city' : city,
                                        'address': _controllerAddress.text,
                                      });

                                      if (request.signedUp) {
                                        print("udah sign up nih");
                                        _signupBankFormKey.currentState?.reset();
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
                    const Text('Have an account?'),
                    TextButton(
                      child: const Text(
                        'Login here',
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.pop(context);
                        Navigator.pop(context);
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
    child: Text("Close"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Error!"),
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
    title: Text("Great!"),
    content: Text("You have successfully signed up!"),
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
