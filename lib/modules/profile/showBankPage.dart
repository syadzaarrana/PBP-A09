import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:wazzt/modules/profile/editBankPage.dart';
import '../../../widget/Drawer.dart';

import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'dart:async';
import 'dart:core';
import 'package:http/http.dart' as http;

import 'editProfilePage.dart';

class User {
  String name = "";
  String username = "";
  String email = "";
  String age = "";
  String gender = "";
  String city = "";
  String address = "";
  String id = "";

  User({
    required this.name,
    required this.username,
    required this.email,
    required this.age,
    required this.gender,
    required this.city,
    required this.address,
    required this.id,
  });

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      name: data["data"]["data"]["name"],
      username: data["data"]["data"]["username"],
      email: data["data"]["data"]["email"],
      age: data["data"]["data"]["age"],
      gender: data["data"]["data"]["gender"],
      city: data['data']['data']["city"],
      address: data['data']['data']["address"],
      id: data['data']['data']["id"],
    );
  }
}

class ShowBankPage extends StatefulWidget {
  // final String id;
  // ShowProfilePage(this.id) : super(key: null);

  const ShowBankPage({super.key});

  @override
  State<ShowBankPage> createState() => _ShowBankPageState();
}

class _ShowBankPageState extends State<ShowBankPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        // drawer: myDrawer();
        backgroundColor: Colors.teal,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50.0,
              backgroundImage: AssetImage('assets/img/user_icon.png'),
            ),
            Text(
              'Nama Institusi',
              style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: 40.0,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
                height: 50.0,
                width: 150.0,
                child: Divider(color: Colors.teal.shade100)),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.mail,
                  color: Colors.teal,
                ),
                title: Text(
                  'user_email@gmail.com',
                  style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Colors.teal,
                ),
                title: Text(
                  'Domisili',
                  style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0),
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
              child: ListTile(
                leading: Icon(
                  Icons.location_on,
                  color: Colors.teal,
                ),
                title: Text(
                  'Domisili',
                  style: TextStyle(
                      color: Colors.teal.shade900,
                      fontFamily: 'Source Sans Pro',
                      fontSize: 20.0),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 3, left: 3),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  border: Border(
                    bottom: BorderSide(color: Colors.black),
                    top: BorderSide(color: Colors.black),
                    left: BorderSide(color: Colors.black),
                    right: BorderSide(color: Colors.black),
                  )),
              child: MaterialButton(
                minWidth: double.infinity,
                height: 60,
                onPressed: () {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return EditBankPage();
                  }));
                },
                color: Color.fromARGB(255, 165, 223, 153),
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "Edit",
                  style: TextStyle(
                    fontFamily: 'SourceSansPro',
                    fontWeight: FontWeight.w600,
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
