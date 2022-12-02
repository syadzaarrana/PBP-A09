// import dari Flutter
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../../../widget/Drawer.dart';

class BuatSumbanganPage extends StatefulWidget {
  const BuatSumbanganPage({super.key});

  final String title = 'Flutter Demo Home Page';

  @override
  State<BuatSumbanganPage> createState() => _BuatSumbanganPageState();
}

// Yang perlu di post itu:
// jenis sampah
// berat sampah

class _BuatSumbanganPageState extends State<BuatSumbanganPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController beratSampahField = TextEditingController(text: ""); // (int)
  String jenisSampahField = "";

  Future<void> submit(BuildContext context, String idUser) async {
    String idPemilik = idUser;
    final response = await http.post(
        Uri.parse(
            "https://wazzt.up.railway.app/buat_sumbangan/flutter/" ),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'berat': beratSampahField.text,
          'jenis-sampah': int.parse(idPemilik),
          'donatur' : 1, //widget.id,
          'bank_sampah': 2 // dari syadza harusnya widget.fields["title"],
        }));
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // drawer: NavigationDrawerWidget(), belum
      appBar: AppBar(
        title: Text("Halaman Buat Sumbangan"),
      ),
      body: Form(
        key: _formKey,
        child: Container(
          padding: EdgeInsets.all(20.0),
          child: Column(
            children:[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: beratSampahField,
                  decoration: const InputDecoration(
                    hintText: "Ex: 5",
                    labelText: "Masukkan Jumlah Berat Sampah (Kg)",
                  ),
                  validator: (value){
                    if (value?.isEmpty ?? true){
                      return "Berat sampah tidak boleh kosong";
                    }
                    return null;
                  },
                )
              ),
              RadioListTile(
                title: Text("Karung"),
                value: "karung",
                groupValue: "jenis-sampah",
                onChanged: (value){
                  setState(() {
                    jenisSampahField = "karung";
                  });
                },
              ),
              RadioListTile(
                title: Text("ban"),
                value: "ban",
                groupValue: "jenis-sampah",
                onChanged: (value){
                  setState(() {
                    jenisSampahField = "ban";
                  });
                },
              ),
              RadioListTile(
                title: Text("ember"),
                value: "ember",
                groupValue: "jenis-sampah",
                onChanged: (value){
                  setState(() {
                    jenisSampahField = "ember";
                  });
                },
              ),
              RadioListTile(
                title: Text("plastik"),
                value: "plastik",
                groupValue: "jenis-sampah",
                onChanged: (value){
                  setState(() {
                    jenisSampahField = "plastik";
                  });
                },
              ),
              RadioListTile(
                title: Text("logam"),
                value: "logam",
                groupValue: "jenis-sampah",
                onChanged: (value){
                  setState(() {
                    jenisSampahField = "logam";
                  });
                },
              ),
              RadioListTile(
                title: Text("botol"),
                value: "botol",
                groupValue: "jenis-sampah",
                onChanged: (value){
                  setState(() {
                    jenisSampahField = "botol";
                  });
                },
              ),

              TextButton(
                child: Text("Submit", style: TextStyle(color: Colors.white),),
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? true) {
                    // String id = widget.id;
                    // showConfirmDialog(context, id);
                  }
                },
              ),

            ]
          )
        )
      )
    );
  }

  showConfirmDialog(BuildContext context, String idUser) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Tidak jadi"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    Widget continueButton = TextButton(
      child: Text("Iya"),
      onPressed: () {
        submit(context, idUser);
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => BuatProjectPage(idUser)));
        showAlertDialog(context, idUser);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Apakah Anda Yakin ini Project yang Anda ingin buat?"),
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

  showAlertDialog(BuildContext context, String idUser) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        // Navigator.push(context,
        //     MaterialPageRoute(builder: (context) => BuatProjectPage(idUser)));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Selamat!"),
      content: Text("Proyek Berhasil Dibuat!"),
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



