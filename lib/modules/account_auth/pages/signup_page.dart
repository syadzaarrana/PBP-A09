import 'package:flutter/material.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/account_auth/pages/signup_page_bank.dart';
import 'package:wazzt/modules/account_auth/pages/signup_page_reg.dart';

import '../../../widget/Drawer.dart';
import '../utils/cookie_request.dart';
import 'login_page.dart';

class SignupPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
        drawer: buildDrawer(context),
        appBar: AppBar(
          title: const Text('Sign Up Page'),
        ),
        body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Colors.white,
                  Colors.white,
                  Color(0xFFA5D6A7),
                ],
              ),
            ),
          child: Padding(
              padding: const EdgeInsets.all(30),
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  // Container(
                  //     alignment: Alignment.center,
                  //     padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  //     child: const Text(
                  //       'Sign Up',
                  //       style: TextStyle(
                  //           color: Colors.black,
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 22),
                  //     )),
                  SizedBox(height: 30),
                  InkWell(
                    onTap: () {
                      //signup screen
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignupRegPage(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 15),
                        ],
                      ),
                      // color: Colors.white,
                      width: double.infinity,
                      child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(children: <Widget>[
                            Icon(
                              Icons.group,
                              size: 70.0,
                              color: Colors.lightGreen,
                            ),
                            TextButton(
                              // icon: Icon(Icons.add),
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.lightGreen),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () {
                                //signup screen
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupRegPage(),
                                ));
                              },
                              child: Text(
                                "Create account as a Regular User",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ])
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  InkWell(
                    onTap: () {
                      //signup screen
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => SignupBankPage(),
                      ));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.shade400,
                              spreadRadius: 1,
                              blurRadius: 15),
                        ],
                      ),
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Icon(
                              Icons.maps_home_work,
                              size: 70.0,
                              color: Colors.lightGreen,
                            ),
                            TextButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                    Colors.lightGreen),
                                foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                              ),
                              onPressed: () {
                                //signup screen
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignupBankPage(),
                                ));
                              },
                              child: Text(
                                "Create account as a Waste Bank",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  Row(
                    children: <Widget>[
                      const Text('Have an account?'),
                      TextButton(
                        child: const Text(
                          'Login here',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                            shadows: <Shadow>[
                              Shadow(
                                offset: Offset(3.0, 1.0),
                                blurRadius: 50.0,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                        onPressed: () {
                          //signup screen
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
              ))
        ),
        );
  }
}
