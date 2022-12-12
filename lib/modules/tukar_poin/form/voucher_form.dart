import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:wazzt/modules/tukar_poin/models/voucher_model.dart';
import 'package:wazzt/modules/tukar_poin/tukar_poin.dart';
import 'package:wazzt/widget/Drawer.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class FormVoucher extends StatefulWidget {
  const FormVoucher({super.key});

  @override
  State<FormVoucher> createState() => _FormVoucherState();
}

class Area {
  String name;

  Area({
    required this.name,
  });
}

class _FormVoucherState extends State<FormVoucher> {
  final _formKey = GlobalKey<FormState>();
  String _judul = '';
  String _deskripsi = '';
  double _poinDitukar = 0;
  double _voucherTersedia = 20;
  DateTime? _berlakuSampai = DateTime.now();
  String areas = '';

  static final List<Area> _area = [
    Area(name: "Aceh"),
    Area(name: "Sumatera Utara"),
    Area(name: "Sumatera Barat"),
    Area(name: "Riau"),
    Area(name: "Kepulauan Riau"),
    Area(name: "Jambi"),
    Area(name: "Bengkulu"),
    Area(name: "Sumatera Selatan"),
    Area(name: "Kepulauan Bangka Belitung"),
    Area(name: "Lampung"),
    Area(name: "Banten"),
    Area(name: "DKI Jakarta"),
    Area(name: "Jawa Barat"),
    Area(name: "Jawa Tengah"),
    Area(name: "Daerah Istimewa Yogyakarta"),
    Area(name: "Jawa Timur"),
    Area(name: "Bali"),
    Area(name: "Nusa Tenggara Barat"),
    Area(name: "Nusa Tenggara Timur"),
    Area(name: "Kalimantan Barat"),
    Area(name: "Kalimantan Tengah"),
    Area(name: "Kalimantan Timur"),
    Area(name: "Kalimantan Utara"),
    Area(name: "Kalimantan Selatan"),
    Area(name: "Sulawesi Barat"),
    Area(name: "Sulawesi Selatan"),
    Area(name: "Sulawesi Tenggara"),
    Area(name: "Sulawesi Tengah"),
    Area(name: "Gorontalo"),
    Area(name: "Sulawesi Utara"),
    Area(name: "Maluku Utara"),
    Area(name: "Maluku"),
    Area(name: "Papua Barat"),
    Area(name: "Papua"),
    Area(name: "Papua Tengah"),
    Area(name: "Papua Pegunungan"),
    Area(name: "Papua Selatan"),
  ];

  final _items = _area.map((area) => MultiSelectItem(area, area.name)).toList();

  List<Area> _areaBerlaku = [];

  @override
  void initState() {
    _areaBerlaku = _area;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Voucher'),
      ),
      drawer: buildDrawer(context),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText: "Contoh: Cashback ACE HardWare 10%",
                      labelText: "Judul Voucher",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.edit_note),
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
                        return 'Judul tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                      hintText:
                          "Contoh: Tukar poin Anda dan dapatkan cashback ACE HardWare 10%.",
                      labelText: "Deskripsi Voucher",
                      // Menambahkan icon agar lebih intuitif
                      icon: const Icon(Icons.subject),
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    // Menambahkan behavior saat nama diketik
                    onChanged: (String? value) {
                      setState(() {
                        _deskripsi = value!;
                      });
                    },
                    // Menambahkan behavior saat data disimpan
                    onSaved: (String? value) {
                      setState(() {
                        _deskripsi = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'Deskripsi tidak boleh kosong!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(
                        Icons.calendar_month_outlined,
                        color: Color.fromARGB(255, 0, 128, 28),
                      ),
                      const Text(
                        'Berlaku sampai: ',
                        style: TextStyle(fontSize: 16.0),
                      ),
                      const SizedBox(width: 4.0),
                      TextButton(
                        onPressed: (() {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2023),
                          ).then((value) {
                            setState(() {
                              _berlakuSampai = value;
                            });
                          });
                        }),
                        child: Text(
                          _berlakuSampai.toString().split(' ')[0],
                          style: const TextStyle(
                            fontSize: 16.0,
                            // color: Colors.black87,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const ListTile(
                        leading: Icon(Icons.check_box_outlined),
                        title: Text("Syarat dan Ketersediaan"),
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Text('Poin diperlukan: ${_poinDitukar.round()}'),
                          ],
                        ),
                        subtitle: Slider(
                          value: _poinDitukar,
                          max: 500,
                          divisions: 10,
                          label: _poinDitukar.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _poinDitukar = value;
                            });
                          },
                        ),
                      ),
                      MultiSelectDialogField(
                        searchable: true,
                        buttonText: const Text(
                          "  Area Berlaku  ",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        onConfirm: (val) {
                          _areaBerlaku = val;
                        },
                        dialogWidth: MediaQuery.of(context).size.width * 0.7,
                        items: _items,
                        initialValue: _areaBerlaku,
                      ),
                      ListTile(
                        title: Row(
                          children: [
                            Text('Jumlah Voucher: ${_voucherTersedia.round()}'),
                          ],
                        ),
                        subtitle: Slider(
                          value: _voucherTersedia,
                          max: 300,
                          divisions: 20,
                          label: _voucherTersedia.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _voucherTersedia = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                TextButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.green),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      for (var i = 0; i < _areaBerlaku.length; i++) {
                        String area;
                        area = _areaBerlaku[i].name += ' ';
                        areas += area;
                      }
                      
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            content: const Text(
                                'Voucher berhasil ditambahkan.'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () async {
                                  final response = await http.post(
                                    Uri.parse(
                                      "https://web-production-06f3.up.railway.app/tukarpoin/json/"
                                    ),
                                    headers: <String,String>{
                                      'Content-type': 'application/json; charset=UTF-8'
                                    },
                                    body: jsonEncode(<String, dynamic>{
                                      "voucherTitle": _judul,
                                      "voucherDesc": _deskripsi,
                                      "requiredPoin": _poinDitukar,
                                      "requiredArea": areas,
                                      "voucherMount": _voucherTersedia,
                                      "availableTill": _berlakuSampai,

                                    })
                                  );
                                
                                  Navigator.pop(context);
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => TukarPoinPage(),
                                    )); 
                                }, 
                                child: const Text('OK'), 
                              ),
                            ],
                          );
                        },
                      );
                      _formKey.currentState!.reset();
                    }
                  },
                  child: const Text(
                    "Simpan",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
