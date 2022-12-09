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
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: ListView(
              children: <Widget>[
                Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          fontSize: 22),
                    )),
                Container(
                    width: double.infinity,
                    child: TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.lightGreen),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => SignupRegPage(),
                        ));
                      },
                      child: Text("Buat akun sebagai Masyarakat Umum"),
                    )
                ),
                TextButton(
                      style: ButtonStyle(
                        backgroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.lightGreen),
                        foregroundColor:
                        MaterialStateProperty.all<Color>(
                            Colors.white),
                      ),
                      onPressed: () {
                        //signup screen
                        Navigator.of(context)
                            .push(MaterialPageRoute(
                          builder: (context) => SignupBankPage(),
                        ));
                      },
                      child: Text("Buat akun sebagai Bank Sampah"),
                    ),
                Row(
                  children: <Widget>[
                    const Text('Sudah punya akun?'),
                    TextButton(
                      child: const Text(
                        'Login disini',
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
            )));
  }
}
