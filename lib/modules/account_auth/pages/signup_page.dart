import 'package:flutter/material.dart';
import 'dart:core';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/account_auth/pages/signup_page_bank.dart';
import 'package:wazzt/modules/account_auth/pages/signup_page_reg.dart';
import 'package:wazzt/modules/account_auth/pages/temp_auth_page.dart';

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
        // backgroundColor: Colors.greenAccent,
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
                      child: Text("Buat akun sebagai masyarakat umum"),
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
                      child: Text("Buat akun sebagai Bank"),
                    ),
                // Material(
                //   type: MaterialType.transparency,
                //   shape: RoundedRectangleBorder(
                //     borderRadius: BorderRadius.circular(10),
                //     side: const BorderSide(color: Colors.grey, width: 1),
                //   ),
                //   child: InkWell(
                //     onTap: () {},
                //     splashColor: Colors.black26,
                //     child: IntrinsicHeight(
                //       child: Padding(
                //         padding: const EdgeInsets.all(12.0),
                //         child: Column(mainAxisSize: MainAxisSize.min, children: [
                //           // Image.asset(
                //           //   '',
                //           //   fit: BoxFit.cover,
                //           //   width: 80,
                //           //   height: 80,
                //           // ),
                //           const SizedBox(
                //             height: 10,
                //           ),
                //           Text(
                //             'Buat akun untuk masyarakat umum',
                //             style: TextStyle(color: Colors.black),
                //           )
                //         ]),
                //       ),
                //     ),
                //   ),
                // ),
                Row(
                  children: <Widget>[
                    const Text('Sudah punya akun?'),
                    TextButton(
                      child: const Text(
                        'Login disini',
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

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("Coba Lagi"),
    onPressed: () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Gagal!"),
    content: Text("Email dan password tidak cocok!"),
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
        MaterialPageRoute(builder: (context) => const AuthPage()),
      );
      // Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => AuthPage()
      //     )
      // );
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Selamat!"),
    content: Text("Anda berhasil login"),
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
