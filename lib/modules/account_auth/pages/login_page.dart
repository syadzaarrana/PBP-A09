import 'package:flutter/material.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:wazzt/main.dart';
import 'package:wazzt/modules/account_auth/pages/signup_page.dart';

import '../../../widget/Drawer.dart';
import '../utils/cookie_request.dart';

class LoginPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginPage> {
  final _loginFormKey = GlobalKey<FormState>();
  final TextEditingController _controllerEmail = TextEditingController();
  final TextEditingController _controllerPassword = TextEditingController();

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
        resizeToAvoidBottomInset : false,
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: const Text('Login Page'),
        ),
        body: Container(
          padding: const EdgeInsets.fromLTRB(30, 50, 30, 220),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.white,
                Color(0xFFA5D6A7),
              ],
            ),
          ),
          child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      color: Colors.grey,
                      spreadRadius: 1,
                      blurRadius: 20),
                ],
              ),
              // height: 50,
              child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 40, 20, 20),
              child: ListView(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      'Login',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22),
                    ),
                  ),
                  Form(
                      key: _loginFormKey,
                      child: Container(
                          padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(250, 250, 250, 0.95),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextFormField(
                                  controller: _controllerEmail,
                                  decoration: InputDecoration(
                                    labelText: 'Email or Username',
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
                                    hintText: 'Email or Username',
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
                              SizedBox(height: 20),
                              Container(
                                decoration: BoxDecoration(
                                  color: Color.fromRGBO(250, 250, 250, 0.95),
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: TextFormField(
                                  controller: _controllerPassword,
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
                                    border: UnderlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.lightGreen),
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
                                      return "Password can not be blank!";
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
                                      if (_loginFormKey.currentState!
                                          .validate()) {
                                        // Untuk local host Chrome
                                        // const url = "http://127.0.0.1:8000/authentication/login_flutter/";

                                        // Untuk local host Android Emulator
                                        // const url = "http://10.0.2.2:8000/authentication/login_flutter/";

                                        // Untuk railway app
                                        const url = "https://wazzt.up.railway.app/authentication/login_flutter/";

                                        final response =
                                        await request.login(url, {
                                          'email': _controllerEmail.text,
                                          'password': _controllerPassword.text,
                                        });
                                        _loginFormKey.currentState?.reset();
                                        if (request.loggedIn) {
                                          print("udah login nih");
                                          showAlertDialog2(context);
                                        } else {
                                          print("blm login nih");
                                          showAlertDialog(context);
                                        }

                                      } else {
                                        print("tidak valid");
                                      }
                                    },
                                    child: Text("Login"),
                                  ))
                            ],
                          ))),
                  Row(
                    children: <Widget>[
                      const Text("Don't have an account?"),
                      TextButton(
                        child: const Text(
                          'Sign up here',
                          style: TextStyle(
                            fontWeight: FontWeight.bold
                          )
                        ),
                        onPressed: () {
                          //signup screen
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignupPage(),
                              ));
                        },
                      ),

                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  )
                ],
              ))
          ),

        ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Close"),
    onPressed: () {
      Navigator.pop(context);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("An error occured!"),
    content: Text("Incorrect email, username, or password. Please try again."),
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
        MaterialPageRoute(
            builder: (context) => const MyHomePage(title: "")
        ),
      );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Great!"),
    content: Text("Your login was successful."),
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
