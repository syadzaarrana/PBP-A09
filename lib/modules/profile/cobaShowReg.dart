// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import '../../../widget/Drawer.dart';

// import 'dart:async';
// import 'dart:core';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'editProfilePage.dart';

// Future<User> fetchUser(String ID) async {
//   String id = ID;

//   var url = "https://wazzt.up.railway.app/for_profile/show_profile/" + id;
//   try {
//     final response = await http.get(Uri.parse(url));
//     print(response);
//     print("ABC");
//     print(response.body);
//     print(url);
//     ;
//     Map<String, dynamic> data = jsonDecode(response.body);
//     print("ABC");
//     print(data);

//     return User.fromJson(jsonDecode(response.body));
//   } catch (error) {
//     print("error");
//     rethrow;
//   }
// }

// class User {
//   String name = "";
//   String username = "";
//   String email = "";
//   String age = "";
//   String gender = "";
//   String city = "";
//   // String address = "";
//   String id = "";
//   bool? is_regular;

//   User(
//       {required this.name,
//       required this.username,
//       required this.email,
//       required this.age,
//       required this.gender,
//       required this.city,
//       // required this.address,
//       required this.id,
//       required this.is_regular});

//   factory User.fromJson(Map<String, dynamic> data) {
//     return User(
//       name: data["data"]["data"]["name"],
//       username: data["data"]["data"]["username"],
//       email: data["data"]["data"]["email"],
//       age: data["data"]["data"]["age"],
//       gender: data["data"]["data"]["gender"],
//       city: data['data']['data']["city"],
//       // address: data['data']['data']["address"],
//       id: data['data']['data']["id"],
//       is_regular: data["data"]["data"]["is_regular"],
//     );
//   }
// }

// class ShowProfilePage extends StatefulWidget {
//   final String id;
//   ShowProfilePage(this.id) : super(key: null);

//   // const ShowProfilePage({super.key});

//   @override
//   // State<ShowProfilePage> createState() => _ShowProfilePageState();
//   _ShowProfilePageState createState() => _ShowProfilePageState();
// }

// class _ShowProfilePageState extends State<ShowProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     print(name + "ABC");
//     print(username);
//     print(email);
//     print(age);
//     print(gender);
//     print(city);
//     String id = widget.id;
//     Future<User> futureUser = fetchUser(id);
//     return Scaffold(
//       // drawer: NavigationDrawerWidget(),
//       appBar: AppBar(
//         // The title text which will be shown on the action bar
//         title: Text("Profile"),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: [
//             Container(
//                 alignment: Alignment.center,
//                 decoration: BoxDecoration(),
//                 child: Padding(
//                   padding: const EdgeInsets.all(15.0),
//                   child: Text(
//                     "Your Profile",
//                     style: TextStyle(
//                       color: Colors.lightGreen,
//                       fontSize: 30,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 )),

//             CircleAvatar(
//                 radius: 50.0,
//                 backgroundImage: AssetImage('assets/img/user_icon.png'),
//               ),

//             FractionallySizedBox(
//               widthFactor: 0.7,
//               //alignment: Alignment.topCenter,
//               child: Container(
//                 alignment: Alignment.center,
//                 padding: EdgeInsets.all(20.0),
//                 decoration: BoxDecoration(
//                   gradient: LinearGradient(
//                       begin: Alignment.centerLeft,
//                       end: Alignment.centerRight,
//                       colors: [Colors.purple, Colors.blue]),
//                   borderRadius: BorderRadius.circular(10.0),
//                 ),
//                 child: Column(
//                   //mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Container(
//                       //margin: EdgeInsets.only(bottom: 5.0),
//                       child: Text(
//                         "Nama :",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: FutureBuilder<User>(
//                           future: futureUser,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               //id = snapshot.data.id;
//                               return Text(
//                                 snapshot.data.name,
//                                 style: TextStyle(
//                                   color: Colors.teal,
//                                   fontFamily: 'Source Sans Pro',
//                                   fontSize: 20.0,
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text("${snapshot.error}");
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                     ),

//                     Container(
//                       //margin: EdgeInsets.only(bottom: 5.0),
//                       child: Text(
//                         "Username :",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: FutureBuilder<User>(
//                           future: futureUser,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               //id = snapshot.data.id;
//                               return Text(
//                                 snapshot.data.username,
//                                 style: TextStyle(
//                                   color: Colors.teal,
//                                   fontFamily: 'Source Sans Pro',
//                                   fontSize: 20.0,
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text("${snapshot.error}");
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                     ),
                    
//                     Container(
//                       margin: EdgeInsets.only(top: 5.0),
//                       child: Text(
//                         "Email :",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: FutureBuilder<User>(
//                           future: futureUser,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Text(
//                                 snapshot.data.email,
//                                 style: TextStyle(
//                                   color: Colors.teal,
//                                   fontFamily: 'Source Sans Pro',
//                                   fontSize: 20.0
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text("${snapshot.error}");
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 5.0),
//                       child: Text(
//                         "Umur :",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: FutureBuilder<User>(
//                           future: futureUser,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Text(
//                                 snapshot.data.age,
//                                 style: TextStyle(
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.white,
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text("${snapshot.error}");
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                     ),
//                     Container(
//                       margin: EdgeInsets.only(top: 5.0),
//                       child: Text(
//                         "Gender :",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: FutureBuilder<User>(
//                           future: futureUser,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Text(
//                                 snapshot.data.gender,
//                                 style: TextStyle(
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.white,
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text("${snapshot.error}");
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                     ),
                    
//                     Container(
//                       margin: EdgeInsets.only(top: 5.0),
//                       child: Text(
//                         "Kota :",
//                         style: TextStyle(
//                           fontSize: 12.0,
//                           fontWeight: FontWeight.w500,
//                           color: Colors.white,
//                         ),
//                       ),
//                     ),
//                     FractionallySizedBox(
//                       widthFactor: 0.9,
//                       child: Container(
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: Colors.lightBlue,
//                           borderRadius: BorderRadius.circular(5.0),
//                         ),
//                         child: FutureBuilder<User>(
//                           future: futureUser,
//                           builder: (context, snapshot) {
//                             if (snapshot.hasData) {
//                               return Text(
//                                 snapshot.data.city,
//                                 style: TextStyle(
//                                   fontSize: 15.0,
//                                   fontWeight: FontWeight.w300,
//                                   color: Colors.white,
//                                 ),
//                               );
//                             } else if (snapshot.hasError) {
//                               return Text("${snapshot.error}");
//                             }
//                             return CircularProgressIndicator();
//                           },
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//             FractionallySizedBox(
//               widthFactor: 0.7,
//               child: Container(
//                 margin: EdgeInsets.only(top: 10.0),
//                 color: Colors.lightBlue,
//                 child: MaterialButton(
//                   minWidth: double.infinity,
//                   height: 60,
//                   onPressed: () {
//                     // Navigator.of(context)
//                     //     .pushReplacement(MaterialPageRoute(builder: (context) {
//                     //   return EditProfilePage();
//                     // }));
//                   },
//                   color: Color.fromARGB(255, 165, 223, 153),
//                   elevation: 0,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(50),
//                   ),
//                   child: Text(
//                     "Edit",
//                     style: TextStyle(
//                       fontFamily: 'Source Sans Pro',
//                       fontWeight: FontWeight.w600,
//                       fontSize: 18,
//                       color: Colors.white,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
