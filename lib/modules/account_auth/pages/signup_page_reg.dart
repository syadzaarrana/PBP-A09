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
                      'for Regular User',
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
                                  labelText: 'Full Name',
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
                                  hintText: 'Full Name',
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
                                    return "Username can not be blank!";
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
                                  labelText: 'Age',
                                  labelStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 15,
                                      fontFamily: 'AvenirLight'),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                    BorderSide(color: Colors.green),
                                  ),
                                  hintText: 'Age',
                                  prefixIcon: Icon(Icons.group),
                                  hintStyle: TextStyle(
                                    color: Color.fromRGBO(200, 200, 200, 1),
                                  ),
                                ),
                                autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Age must be a number!";
                                  }
                                  else if (!isInRange(value) ){
                                    return 'Age must be between 13 to 100!';
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
                                const Text("Gender: ",
                                  style: TextStyle(
                                      fontSize: 15,
                                  ),),
                                RadioListTile(
                                  dense: true,
                                  title: Text("Male",
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
                                  title: Text("Female",
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
                                  title: Text("Rather not say",
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
                                  hint: Text('Domicile (Province)'),
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
                    const Text('Have an account?'),
                    TextButton(
                      child: const Text(
                        'Login here',
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
