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
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Your Question Here'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ForumPage(),
                ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
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
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(8, 30, 8, 69),
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Image.network(
                      "https://cdn-icons-png.flaticon.com/512/2784/2784530.png",
                      height: 130,
                      fit: BoxFit.fill),
                  SizedBox(
                    height: 65,
                  ),
                  Padding(
                    // Menggunakan padding sebesar 8 pixels
                    padding: const EdgeInsets.all(15.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: "Title",
                        // Menambahkan icon agar lebih intuitif
                        icon: const Icon(
                            IconData(0xe4fb, fontFamily: 'MaterialIcons')),
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
                          return 'Title cannot empty!';
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
                        labelText: "Questions",
                        // Menambahkan icon agar lebih intuitif
                        icon: const Icon(
                            IconData(0xf00cf, fontFamily: 'MaterialIcons')),
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
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return 'Question cannot empty!';
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
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
                            child: const Text('Successfully added a question')),
                        SizedBox(height: 20),
                        ElevatedButton(
                          child: Text('Go Back to FAQ'),
                          style: ElevatedButton.styleFrom(
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
        label: const Text('Save your Question to FAQ'),
        icon: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 102, 243, 193),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
