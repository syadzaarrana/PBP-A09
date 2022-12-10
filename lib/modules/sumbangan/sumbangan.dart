// import dari Flutter
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/sumbangan/history.dart';
import 'package:wazzt/modules/account_auth/pages/signup_page_bank.dart';
import '../../../widget/Drawer.dart';
import '../account_auth/utils/cookie_request.dart';

bool isInRange(String str) {
  return (int.parse(str) >= 1) && (int.parse(str) <= 100);
}

class BuatSumbanganPage extends StatefulWidget {
  const BuatSumbanganPage({super.key, required this.id_bank_sampah});
  final int id_bank_sampah;

  @override
  State<BuatSumbanganPage> createState() => _BuatSumbanganPageState();
}

// Yang perlu di post itu:
// jenis sampah
// berat sampah

class _BuatSumbanganPageState extends State<BuatSumbanganPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _beratSampahField =
      TextEditingController(text: ""); // (int)
  String? jenis;

  Future<void> submit(BuildContext context, int idPemilik) async {
    print(idPemilik);
    final response = await http.post(
        Uri.parse("https://wazzt.up.railway.app/sumbang/flutter/"),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'berat': _beratSampahField.text,
          'jenis': jenis,
          'donatur': idPemilik,
          'bank_sampah': widget.id_bank_sampah,
        }));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    int idPemilik = request.id;
    return Scaffold(
        // drawer: NavigationDrawerWidget(), belum
        appBar: AppBar(
          title: Text("Halaman Buat Sumbangan"),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                padding: EdgeInsets.all(20.0),
                child: Column(children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color.fromRGBO(250, 250, 250, 0.95),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: TextFormField(
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      keyboardType: TextInputType.number,
                      controller: _beratSampahField,
                      decoration: InputDecoration(
                        labelText: 'Berat Sampah (Kg)',
                        labelStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 15,
                            fontFamily: 'AvenirLight'),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.green),
                        ),
                        border: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightGreen),
                        ),
                        hintText: 'Ex: 5',
                        // prexixIcon : Icon(Icons.account_circle),
                        hintStyle: TextStyle(
                          color: Color.fromRGBO(200, 200, 200, 1),
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Silakan masuki berat";
                        } else if (!isInRange(value)) {
                          return 'Berat di antara 1-100 Kg';
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      const Text(
                        "Jenis Sampah: ",
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text(
                          "Karung",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        value: "karung",
                        groupValue: jenis,
                        onChanged: (value) {
                          setState(() {
                            jenis = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text(
                          "Ban",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        value: "ban",
                        groupValue: jenis,
                        onChanged: (value) {
                          setState(() {
                            jenis = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text(
                          "Ember",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        value: "ember",
                        groupValue: jenis,
                        onChanged: (value) {
                          setState(() {
                            jenis = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text(
                          "Plastik",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        value: "plastik",
                        groupValue: jenis,
                        onChanged: (value) {
                          setState(() {
                            jenis = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text(
                          "Logam",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        value: "logam",
                        groupValue: jenis,
                        onChanged: (value) {
                          setState(() {
                            jenis = value.toString();
                          });
                        },
                      ),
                      RadioListTile(
                        dense: true,
                        title: Text(
                          "Botol",
                          style: TextStyle(
                            fontSize: 15,
                            color: Color.fromRGBO(90, 90, 90, 1),
                          ),
                        ),
                        value: "botol",
                        groupValue: jenis,
                        onChanged: (value) {
                          setState(() {
                            jenis = value.toString();
                          });
                        },
                      ),
                    ],
                  ),
                  Container(
                      width: double.infinity,
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        onPressed: () async {
                          if (_formKey.currentState?.validate() ?? true) {
                            showConfirmDialog(context, idPemilik);
                            // submit(context, idPemilik);
                            print("valid");
                          } else {
                            print("tidak valid");
                          }
                        },
                        child: Text("Donate!"),
                      ))
                ]))));
  }

  showConfirmDialog(BuildContext context, int idUser) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Tidak"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Text("Iya"),
      onPressed: () {
        submit(context, idUser);
        showAlertDialog(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Konfirmasi"),
      content: Text("Apakah yakin ini donasi yang Anda ingin buat?"),
      actions: [
        cancelButton,
        continueButton,
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

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HistoryPage()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Selamat!"),
      content: Text("Donasi Berhasil Dibuat!"),
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
}
