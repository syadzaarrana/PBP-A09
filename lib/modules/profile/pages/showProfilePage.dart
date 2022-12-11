// import 'package:flutter/material.dart';
// import 'package:flutter/cupertino.dart';
// import '../../../widget/Drawer.dart';

// import 'dart:async';
// import 'dart:core';
// import 'dart:convert';
// import 'package:http/http.dart' as http;

// import 'editProfilePage.dart';


// class ShowProfilePage extends StatefulWidget {

//   const ShowProfilePage({Key? key}) : super(key: key);

//   @override
//   // State<ShowProfilePage> createState() => _ShowProfilePageState();
//   _ShowProfilePageState createState() => _ShowProfilePageState();
// }

// class _ShowProfilePageState extends State<ShowProfilePage> {
//   @override
//   Widget build(BuildContext context) {
//     // print(name + "ABC");
//     // print(username);
//     // print(email);
//     // print(age);
//     // print(gender);
//     // print(city);

//     return MaterialApp(
//       home: Scaffold(
//         // drawer: myDrawer();
//         backgroundColor: Colors.white,
//         body: SafeArea(
//             child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               radius: 50.0,
//               backgroundImage: AssetImage('assets/img/user_icon.png'),
//             ),
//             // Text(
//             //   'Name',
//             //   style: TextStyle(
//             //       fontFamily: 'Pacifico',
//             //       fontSize: 40.0,
//             //       color: Colors.teal,
//             //       fontWeight: FontWeight.bold),
//             // ),

//             // Text(
//             //   'Username',
//             //   style: TextStyle(
//             //       fontFamily: 'Source Sans Pro',
//             //       color: Colors.teal.shade100,
//             //       fontSize: 20.0,
//             //       letterSpacing: 2.5,
//             //       fontWeight: FontWeight.bold),
//             // ),
//             SizedBox(
//                 height: 50.0,
//                 width: 150.0,
//                 child: Divider(color: Colors.teal.shade100)),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.mail,
//                   color: Colors.teal,
//                 ),
//                 title: Text(
//                   'user_email@gmail.com',
//                   style: TextStyle(
//                       color: Colors.teal,
//                       fontFamily: 'Source Sans Pro',
//                       fontSize: 20.0),
//                 ),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//               child: ListTile(
//                 leading: Icon(
//                   CupertinoIcons.smiley,
//                   color: Colors.teal,
//                 ),
//                 title: Text(
//                   '[__] Tahun',
//                   style: TextStyle(
//                       color: Colors.teal,
//                       fontFamily: 'Source Sans Pro',
//                       fontSize: 20.0),
//                 ),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.attribution_rounded,
//                   color: Colors.teal,
//                 ),
//                 title: Text(
//                   'Gender',
//                   style: TextStyle(
//                       color: Colors.teal,
//                       fontFamily: 'Source Sans Pro',
//                       fontSize: 20.0),
//                 ),
//               ),
//             ),
//             Card(
//               margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//               child: ListTile(
//                 leading: Icon(
//                   Icons.home,
//                   color: Colors.teal,
//                 ),
//                 // title: Text(
//                 //   'Domisili',
//                 //   style: TextStyle(
//                 //       color: Colors.teal,
//                 //       fontFamily: 'Source Sans Pro',
//                 //       fontSize: 20.0),
//                 // ),
//               ),
//             ),
//             Container(
//               padding: EdgeInsets.only(top: 3, left: 3),
//               decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50),
//                   border: Border(
//                     bottom: BorderSide(color: Colors.black),
//                     top: BorderSide(color: Colors.black),
//                     left: BorderSide(color: Colors.black),
//                     right: BorderSide(color: Colors.black),
//                   )),
//               child: MaterialButton(
//                 minWidth: double.infinity,
//                 height: 60,
//                 onPressed: () {
//                   // Navigator.of(context)
//                   //     .pushReplacement(MaterialPageRoute(builder: (context) {
//                   //   return EditProfilePage();
//                   // }));
//                 },
//                 color: Color.fromARGB(255, 165, 223, 153),
//                 elevation: 0,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(50),
//                 ),
//                 child: Text(
//                   "Edit",
//                   style: TextStyle(
//                     fontFamily: 'Source Sans Pro',
//                     fontWeight: FontWeight.w600,
//                     fontSize: 18,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         )),
//       ),
//     );
//   }
// }
