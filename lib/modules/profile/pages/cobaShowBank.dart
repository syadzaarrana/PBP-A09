import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/account_auth/models/auth_models.dart';
import '../../../../widget/Drawer.dart';

import 'dart:async';
import 'dart:core';
import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../../main.dart';
import '../../account_auth/utils/cookie_request.dart';
import '../utils/fetch.dart';
import 'editBankPage.dart';

class ShowBankPage extends StatefulWidget {
  final String id;
  ShowBankPage(this.id) : super(key: null);

  // const ShowProfilePage({super.key});

  @override
  // State<ShowProfilePage> createState() => _ShowProfilePageState();
  _ShowBankPageState createState() => _ShowBankPageState();
}

class _ShowBankPageState extends State<ShowBankPage> {
  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    int id = request.id;
    Future<User> futureUser = fetchUser(id);
    return Scaffold(
      drawer: buildDrawer(context),
      appBar: AppBar(
        // The title text which will be shown on the action bar
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(),
                child: const Padding(
                  padding: EdgeInsets.all(15.0),
                  child: Text(
                    "Your Profile",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Pacifico'),
                  ),
                )),
            SizedBox(height: 10,),

            CircleAvatar(
                radius:50.0,
                backgroundColor: Colors.white,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(50.0),
                  child: Image.asset('assets/img/bank_icon.png')),
                // backgroundImage: AssetImage('assets/img/user_icon.png'),
              ),
            SizedBox(height: 30,),
            FractionallySizedBox(
              widthFactor: 0.7,
              //alignment: Alignment.topCenter,
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.white, Colors.white]),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  //mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      //margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Institute Name :",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 165, 223, 153),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: FutureBuilder<User>(
                          future: fetchUser(id),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              //id = snapshot.data.id;
                              print('data ${snapshot.data!.name.toString()}');
                              return Text(
                                snapshot.data!.name.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15.0,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "Email :",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 165, 223, 153),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: FutureBuilder<User>(
                          future: futureUser,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.email.toString(),
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'Source Sans Pro',
                                    fontSize: 15.0),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),

                    Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Text(
                        "City :",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 165, 223, 153),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: FutureBuilder<User>(
                          future: futureUser,
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Text(
                                snapshot.data!.city.toString(),
                                style: TextStyle(
                                  fontSize: 15.0,
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                    Container(
                      //margin: EdgeInsets.only(bottom: 5.0),
                      child: Text(
                        "Address :",
                        style: TextStyle(
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500,
                          color: Colors.teal,
                        ),
                      ),
                    ),
                    FractionallySizedBox(
                      widthFactor: 0.9,
                      child: Container(
                        padding: EdgeInsets.all(8.0),
                        decoration: BoxDecoration(
                          color: Color.fromARGB(255, 165, 223, 153),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: FutureBuilder<User>(
                          future: fetchUser(id),
                          builder: (context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              //id = snapshot.data.id;
                              print('data ${snapshot.data!.address.toString()}');
                              return Text(
                                snapshot.data!.address.toString(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Source Sans Pro',
                                  fontSize: 15.0,
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text("${snapshot.error}");
                            }
                            return CircularProgressIndicator();
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30,),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                color: Colors.white,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return EditBankPage(id.toString());
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
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            FractionallySizedBox(
              widthFactor: 0.7,
              child: Container(
                margin: EdgeInsets.only(top: 10.0),
                color: Colors.white,
                child: MaterialButton(
                  minWidth: double.infinity,
                  height: 60,
                  onPressed: () {
                    Navigator.of(context)
                        .pushReplacement(MaterialPageRoute(builder: (context) {
                      return MyHomePage(title: "");
                    }));
                  },
                  color: Color.fromARGB(255, 165, 223, 153),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  child: Text(
                    "Back",
                    style: TextStyle(
                      fontFamily: 'Source Sans Pro',
                      fontWeight: FontWeight.w600,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
