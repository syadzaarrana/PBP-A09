import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/widget/Drawer.dart';

import 'modules/account_auth/pages/login_page.dart';
import 'modules/account_auth/utils/cookie_request.dart';
import 'modules/leaderboard/models/bank_model.dart';
import 'modules/description/pages/description.dart';
import 'package:wazzt/modules/leaderboard/leaderboard.dart';
import 'dart:convert';

import 'package:wazzt/modules/leaderboard/utils/fetch.dart';


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
            primarySwatch: Colors.green,
          ),
          // home: const MyHomePage(title: 'KonvaSearch'),
          home: MyHomePage(title: "Wazzt"),
          routes: {"/login": (BuildContext context) => LoginPage()},
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

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
                        style: TextStyle(
                            color: Color(0xff59A5D8), fontSize: 20),),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) =>
                          ListTile(
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
                                            color: Colors.black,
                                            blurRadius: 2.0)
                                      ]),
                                  // statusMovie[index]
                                  //     ?
                                  //     : BoxDecoration(
                                  //     color: Colors.red,
                                  //     borderRadius: BorderRadius.circular(15.0),
                                  //     boxShadow: const [
                                  //       BoxShadow(
                                  //           color: Colors.black,
                                  //           blurRadius: 2.0)
                                  //     ]),

                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
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
                                          child: const Text("See description",
                                            style: TextStyle(
                                                color: Colors.cyanAccent),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty
                                                .all(Colors.white12),
                                          ),
                                          onPressed: () {
                                            Navigator.pushReplacement(context,
                                              MaterialPageRoute(builder: (
                                                  context) => const DescriptionPage()),
                                            );
                                          }
                                      ),


                                    ],
                                  ),
                                ),
                              )));
                }
              }
            }));
  }
// int _counter = 0;
//
// void _incrementCounter() {
//   setState(() {
//     // This call to setState tells the Flutter framework that something has
//     // changed in this State, which causes it to rerun the build method below
//     // so that the display can reflect the updated values. If we changed
//     // _counter without calling setState(), then the build method would not be
//     // called again, and so nothing would appear to happen.
//     _counter++;
//   });
// }
//
// @override
// Widget build(BuildContext context) {
//   // This method is rerun every time setState is called, for instance as done
//   // by the _incrementCounter method above.
//   //
//   // The Flutter framework has been optimized to make rerunning build methods
//   // fast, so that you can just rebuild anything that needs updating rather
//   // than having to individually change instances of widgets.
//   return Scaffold(
//     drawer: buildDrawer(context),
//     appBar: AppBar(
//       // Here we take the value from the MyHomePage object that was created by
//       // the App.build method, and use it to set our appbar title.
//       title: Text(widget.title),
//     ),
//     body: Center(
//       // Center is a layout widget. It takes a single child and positions it
//       // in the middle of the parent.
//       child: Column(
//         // Column is also a layout widget. It takes a list of children and
//         // arranges them vertically. By default, it sizes itself to fit its
//         // children horizontally, and tries to be as tall as its parent.
//         //
//         // Invoke "debug painting" (press "p" in the console, choose the
//         // "Toggle Debug Paint" action from the Flutter Inspector in Android
//         // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
//         // to see the wireframe for each widget.
//         //
//         // Column has various properties to control how it sizes itself and
//         // how it positions its children. Here we use mainAxisAlignment to
//         // center the children vertically; the main axis here is the vertical
//         // axis because Columns are vertical (the cross axis would be
//         // horizontal).
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: <Widget>[
//           const Text(
//             'You have pushed the button this many times:',
//           ),
//           Text(
//             '$_counter',
//             style: Theme.of(context).textTheme.headline4,
//           ),
//         ],
//       ),
//     ),
//     floatingActionButton: FloatingActionButton(
//       onPressed: _incrementCounter,
//       tooltip: 'Increment',
//       child: const Icon(Icons.add),
//     ), // This trailing comma makes auto-formatting nicer for build methods.


}
