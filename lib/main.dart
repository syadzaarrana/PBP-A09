import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/description/pages/uploadform.dart';
import 'package:wazzt/widget/Drawer.dart';

import 'modules/account_auth/pages/login_page.dart';
import 'modules/account_auth/utils/cookie_request.dart';
import 'modules/leaderboard/models/bank_model.dart';

import 'modules/leaderboard/utils/fetch.dart';
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
          title: 'Wazzt',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.green,
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.green[400],
              secondary: Colors.green[900],
            ),
          ),
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
  late Future<List<Leaderboard>> shows;
  String searchString = '';

  @override
  void initState() {
    super.initState();
    shows = fetchToDo();
  }

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

    return MaterialApp(
      title: 'Wazzt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.green[400],
          secondary: Colors.green[900],
        ),
      ),
      home: Scaffold(
          drawer: buildDrawer(context),
          appBar: AppBar(title: Text('Wazzt')),
          body: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 200,
                  width: double.infinity,
                  //color: Colors.purple,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xFFA5D6A7),
                  ),
                  child: Center(
                    child: const Text(
                      "Welcome to Wazzt!\nA waste bank application with hope can be solving the waste problem in Indonesia by motivating people to sort waste.",
                      style: TextStyle(
                          height: 2.0,
                          color: Colors.black,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(
                  //color: Colors.purple,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Color(0xFFA5D6A7), width: 3),
                  ),
                  child: Column(
                    children: [
                      Text(
                        "About Us",
                        style: TextStyle(
                            height: 2.0,
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "The waste problem in Indonesia is getting worse. Data shows that every year 2.12 billion tons of waste are generated, of which 33% is not correctly processed and disrupts the environment. Many animals whose environment is disrupted because of garbage, which results in death for these animals. Waste that accumulates in the open air and is not treated properly produces methane gas, a gas that can be a factor in extreme climate change, which also has an impact on global warming."
                      "Therefore, Wazzt is here to provide a point reward system and a leaderboard that can motivate people to participate in better waste management.",
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Vision",
                        style: TextStyle(
                            height: 2.0,
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Making Wazzt a learning platform for people who care about the environment and creating a clean environment from waste.",
                        style: TextStyle(color: Colors.black, fontSize: 14.0),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "Mision",
                        style: TextStyle(
                            height: 2.0,
                            color: Colors.black,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        "⚈Increasing the role of waste banks to benefit the community",
                        style: TextStyle(
                            height: 1.2, color: Colors.black, fontSize: 14.0),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "⚈Empowering the community in independent waste management",
                        style: TextStyle(
                            height: 1.2, color: Colors.black, fontSize: 14.0),
                        textAlign: TextAlign.left,
                      ),
                      Text(
                        "⚈Add value to the use and economy of waste",
                        style: TextStyle(
                            height: 1.2, color: Colors.black, fontSize: 14.0),
                        textAlign: TextAlign.left,
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Text(
                    "List Waste Bank",
                    style: TextStyle(
                        height: 1.2,
                        color: Colors.lightGreen,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        searchString = value.toLowerCase();
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Search name',
                        hintStyle: TextStyle(color: Colors.green),
                        suffixIcon: Icon(Icons.search)),
                    cursorColor: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  builder:
                      (context, AsyncSnapshot<List<Leaderboard>> snapshot) {
                    if (snapshot.hasData) {
                      return Center(
                        child: ListView.separated(
                          shrinkWrap: true,
                          padding: const EdgeInsets.all(8),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return snapshot.data![index].name
                                .toLowerCase()
                                .contains(searchString)
                                ? ListTile(
                                title: Text(
                                  '${snapshot.data?[index].name}',
                                  style: const TextStyle(
                                    color: Colors.lightGreen,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Column(
                                  children: <Widget>[
                                    Text(
                                      'City: ${snapshot.data?[index].city}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      'Address: ${snapshot.data?[index].address}',
                                      style: const TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    TextButton(
                                      child: const Text(
                                        "See Description",
                                        style:
                                        TextStyle(color: Colors.white),
                                      ),
                                      style: ButtonStyle(
                                          backgroundColor:
                                          MaterialStateProperty.all(
                                              Colors.lightGreen)),
                                      onPressed: () {
                                        if (snapshot.hasData) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DescriptionPage(
                                                      regularUser: request
                                                          .is_regular,
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
                                      },
                                    )
                                  ],
                                ))
                                : Container();
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return snapshot.data![index].name
                                .toLowerCase()
                                .contains(searchString)
                                ? Divider()
                                : Container();
                          },
                        ),
                      );
                    }
                    return CircularProgressIndicator();
                  },
                  future: shows,
                ),
              ],
            ),
          )),
    );
  }
}