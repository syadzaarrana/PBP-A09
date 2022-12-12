import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:convert';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import 'package:wazzt/main.dart';

class UploadForm extends StatefulWidget {
  UploadForm({super.key, required this.id});

  final int id;

  @override
  State<UploadForm> createState() => _MyFormPageState();
}

class _MyFormPageState extends State<UploadForm> {
  final _formKey = GlobalKey<FormState>();

  String title = "";

  TextEditingController datePicker = TextEditingController();

  String image = "";
  TextEditingController imagePicker = TextEditingController();
  File? imageFile;

  String description = "";
  TextEditingController textArea = TextEditingController();

  @override
  void initState() {
    datePicker.text = DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  Future pickImage() async {
    final result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        type: FileType.custom,
        allowedExtensions: ['jpg', 'png']);

    setState(() {
      imageFile = File(result!.files.single.path!);
      image = result.files.single.path!;
      imagePicker.text = result.files.single.name;
    });
  }

  Future<void> upload() async {
    Uint8List imagebytes = await imageFile!.readAsBytes();
    String base64Image = base64.encode(imagebytes);

    final response = await http.post(
        Uri.parse('https://wazzt.up.railway.app/descriptions/flutterupload/'),
        headers: <String, String>{'Content-Type': 'application/json'},
        body: jsonEncode(<String, dynamic>{
          'waste_bank': widget.id,
          'title': title,
          'date': datePicker.text,
          'image': base64Image,
          'image_name': imagePicker.text,
          'description': description
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Upload Description'),
      ),
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
                      labelText: "Title",
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Enter title",
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        title = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        title = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: datePicker,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.calendar_today),
                      labelText: "Date",
                    ),
                    readOnly: true,
                    onTap: () async {
                      DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101));

                      setState(() {
                        datePicker.text =
                            DateFormat('yyyy-MM-dd').format(pickedDate!);
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: imagePicker,
                    decoration: const InputDecoration(
                      icon: Icon(Icons.insert_photo_outlined),
                      labelText: "Image",
                    ),
                    readOnly: true,
                    onTap: () async {
                      await pickImage();
                    },
                    onChanged: (String? value) {
                      setState(() {
                        image = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        image = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  // Menggunakan padding sebesar 8 pixels
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: textArea,
                    keyboardType: TextInputType.multiline,
                    maxLines: 3,
                    decoration: InputDecoration(
                      alignLabelWithHint: true,
                      labelText: "Description",
                      // Menambahkan circular border agar lebih rapi
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Enter description",
                    ),
                    onChanged: (String? value) {
                      setState(() {
                        description = value!;
                      });
                    },
                    onSaved: (String? value) {
                      setState(() {
                        description = value!;
                      });
                    },
                    // Validator sebagai validasi form
                    validator: (String? value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required.';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(45)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        upload();
                        showDialog(
                          context: context,
                          builder: (context) {
                            return Dialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              elevation: 15,
                              child: ListView(
                                padding: const EdgeInsets.all(20),
                                shrinkWrap: true,
                                children: <Widget>[
                                  const Center(child: Text('Uploaded Data')),
                                  const SizedBox(height: 20),
                                  Column(
                                    children: [
                                      Text('Title: $title'),
                                      Text('Date: ${datePicker.text}'),
                                      Text('Image: ${imagePicker.text}'),
                                      Text('Description: $description'),
                                    ],
                                  ),
                                  const SizedBox(height: 7),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const MyApp()),
                                      );
                                    },
                                    child: const Text('OK'),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      "Upload",
                      style: TextStyle(color: Colors.white),
                    ),
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
