import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:wazzt/modules/forum/forum.dart';
import 'package:intl/intl.dart';
import 'package:wazzt/widget/Drawer.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/account_auth/utils/cookie_request.dart';
import 'dart:convert';

class MyFormPage extends StatefulWidget {
  const MyFormPage({super.key});

  @override
  State<MyFormPage> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<MyFormPage> {
  final _formKey = GlobalKey<FormState>();
  String _judul = "";
  String _isi = "";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            Color.fromARGB(255, 166, 238, 194),
            Color.fromARGB(255, 255, 255, 255),
          ],
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          title: Text('Tambahkan Pertanyaan Anda'),
        ),
        drawer: buildDrawer(context),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 69),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Image.network(
                      "https://cdn-icons-png.flaticon.com/512/2784/2784530.png",
                      height: 130,
                      fit: BoxFit.fill),
                  Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Judul",
                        // Menambahkan icon agar lebih intuitif
                        icon: const Icon(
                            IconData(0xf520, fontFamily: 'MaterialIcons')),
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Menambahkan behavior saat nama diketik
                      onChanged: (String? value) {
                        setState(() {
                          _judul = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          _judul = value!;
                        });
                      },
                      // Validator sebagai validasi form
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Judul Tidak Boleh Kosong!';
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        labelText: "Pertanyaan",
                        // Menambahkan icon agar lebih intuitif
                        icon: const Icon(
                            IconData(0xf520, fontFamily: 'MaterialIcons')),
                        // Menambahkan circular border agar lebih rapi
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      // Menambahkan behavior saat nama diketik
                      onChanged: (String? value) {
                        setState(() {
                          _isi = value!;
                        });
                      },
                      // Menambahkan behavior saat data disimpan
                      onSaved: (String? value) {
                        setState(() {
                          _isi = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              showDialog(
                context: context,
                builder: (context) {
                  return Dialog(
                    backgroundColor: Color.fromARGB(255, 102, 243, 193),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 15,
                    child: Container(
                      child: ListView(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 20, right: 50, left: 50),
                        shrinkWrap: true,
                        children: <Widget>[
                          Center(
                              child: const Text(
                                  'Berhasil Menambahkan Pertanyaan')),
                          SizedBox(height: 20),
                          ElevatedButton(
                            child: Text('Kembali'),
                            style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 120.0, vertical: 25.0),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)),
                                primary: Color.fromARGB(255, 14, 152, 104)),
                            onPressed: () async {
                              final response = await http.post(
                                  Uri.parse(
                                      "https://wazzt.up.railway.app/forum/addFlutter/"),
                                  headers: <String, String>{
                                    'Content-Type':
                                        'application/json; charset=UTF-8'
                                  },
                                  body: jsonEncode(<String, dynamic>{
                                    "author": request.id,
                                    "title": _judul,
                                    "body": _isi,
                                  }));
                              Navigator.pop(context);
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ForumPage(),
                                  )); //
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
          label: const Text('Tambahkan Pertanyaan'),
          icon: const Icon(Icons.add),
          backgroundColor: Color.fromARGB(255, 102, 243, 193),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
