import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/description/pages/uploadform.dart';
import 'package:wazzt/widget/Drawer.dart';

import 'modules/account_auth/pages/login_page.dart';
import 'modules/account_auth/utils/cookie_request.dart';
import 'modules/leaderboard/models/bank_model.dart';
import 'modules/description/pages/description.dart';
import 'dart:convert';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
        create: (_) {
          CookieRequest request = CookieRequest();

          return request;
        },
        child: MaterialApp(
          title: 'KonvaSearch',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            // colorScheme: ColorScheme.fromSwatch().copyWith(
            //     secondary: Colors.greenAccent),
            // fontFamily: 'Lato',
            primarySwatch: Colors.green,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.green[400],
              secondary: Colors.green[900],
            ),
          ),
          // home: const MyHomePage(title: 'KonvaSearch'),
          home: MyHomePage(title: "Wazzt"),
          routes: {"/login": (BuildContext context) => LoginPage()},
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Leaderboard>> fetchToDo() async {
    var url = Uri.parse('https://wazzt.up.railway.app/leaderboard/data_json/');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object WatchList
    List<Leaderboard> listUser = [];

    for (var d in data) {
      if (d != null) {
        listUser.add(Leaderboard.fromJson(d));
      }
    }
    return listUser;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Bank Sampah'),
      ),
      drawer: buildDrawer(context),
      body: FutureBuilder(
          future: fetchToDo(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Belum ada bank sampah",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) => ListTile(
                        title: GestureDetector(
                            child: Container(
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 16, vertical: 12),
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(15.0),
                                    boxShadow: const [
                                      BoxShadow(
                                          color: Colors.black, blurRadius: 2.0)
                                    ]),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${snapshot.data![index].name}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data![index].city}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        "${snapshot.data![index].address}",
                                        style: const TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      TextButton(
                                          child: const Text(
                                            "See description",
                                            style: TextStyle(
                                                color: Colors.cyanAccent),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white12),
                                          ),
                                          onPressed: () {
                                            if (snapshot.hasData) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DescriptionPage(
                                                          id: snapshot
                                                              .data![index].pk,
                                                          name: snapshot
                                                              .data![index]
                                                              .name,
                                                          city: snapshot
                                                              .data![index]
                                                              .city,
                                                          email: snapshot
                                                              .data![index]
                                                              .email,
                                                        )),
                                              );
                                            }
                                          }),
                                      TextButton(
                                          child: const Text(
                                            "Add description",
                                            style: TextStyle(
                                                color: Colors.cyanAccent),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all(
                                                    Colors.white12),
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      UploadForm(
                                                        id: snapshot
                                                            .data![index].pk,
                                                      )),
                                            );
                                          }),
                                      Visibility(
                                        visible: request.is_bank ? true : false,
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            TextButton(
                                                child: const Text(
                                                  "Add description",
                                                  style: TextStyle(
                                                      color: Colors.cyanAccent),
                                                ),
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                          Colors.white12),
                                                ),
                                                onPressed: () {
                                                  Navigator.pushReplacement(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UploadForm(
                                                              id: snapshot
                                                                  .data![index]
                                                                  .pk,
                                                            )),
                                                  );
                                                }),
                                          ],
                                        ),
                                      ),
                                    ])))));
              }
            }
          }),
    );
  }
}
