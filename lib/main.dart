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
          body:
          SingleChildScrollView(
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
                    child : const Text("Selamat datang di Wazzt!\nAplikasi bank sampah dengan harapan dapat mengatasi permasalahan sampah di Indonesia dengan memotivasi masyarakat untuk memilah sampah.",
                      style: TextStyle(height: 2.0,color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold), textAlign: TextAlign.center,),
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
                      Text ("About Us",
                        style: TextStyle(height: 2.0,color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                      Text ("Permasalahan sampah di Indonesia yang semakin buruk. Data menunjukkan, bahwa setiap tahunnya dihasilkan 2.12 miliar ton sampah, yang 33% darinya tidak diolah dengan baik dan mengganggu lingkungan. Banyak hewan-hewan yang terganggu lingkungan hidupnya karena sampah, yang mengakibatkan kematian bagi hewan-hewan tersebut. Sampah-sampah yang menumpuk pada udara terbuka dan tidak diolah dengan baik menghasilkan gas metana yang merupakan salah satu gas yang dapat menjadi salah satu faktor terjadinya perubahan iklim yang ekstrim sehingga berdampak juga terhadap pemanasan global."
                          "Oleh karena itu, Wazzt hadir dengan menyediakan sistem point reward dan leaderboard yang dapat menjadi motivasi masyrakat untuk ikut dalam pengelolaan sampah yang lebih baik.",
                        style: TextStyle(color: Colors.black, fontSize: 14.0), textAlign: TextAlign.left,),
                      Text ("Visi",
                        style: TextStyle(height: 2.0,color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold ), textAlign: TextAlign.left,),
                      Text ("Menjadikan Wazzt sebagai wadah pembelajaran untuk masyarakat yang peduli akan lingkungan dan mewujudkan lingkungan yang bersih dari sampah.",
                        style: TextStyle(color: Colors.black, fontSize: 14.0 ), textAlign: TextAlign.left,),
                      Text ("Misi",
                        style: TextStyle(height: 2.0,color: Colors.black, fontSize: 16.0, fontWeight: FontWeight.bold ), textAlign: TextAlign.center,),
                      Text ("⚈Meningkatkan peran bank sampah agar bermanfaat bagi masyarakat",
                        style: TextStyle(height: 1.2 ,color: Colors.black, fontSize: 14.0), textAlign: TextAlign.left,),
                      Text ("⚈Memberdayakan masyarakat dalam kemandirian pengelolaan sampah",
                        style: TextStyle(height: 1.2 ,color: Colors.black, fontSize: 14.0), textAlign: TextAlign.left,),
                      Text ("⚈Menambah nilai guna dan ekonomi dari sampah",
                        style: TextStyle(height: 1.2 ,color: Colors.black, fontSize: 14.0), textAlign: TextAlign.left,),
                    ],
                  ),
                ),
                Center(
                  child: Text ("Daftar Bank Sampah",
                    style: TextStyle(height: 1.2 ,color: Colors.lightGreen, fontSize: 22.0, fontWeight: FontWeight.bold), textAlign: TextAlign.left,),
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
                        labelText: 'Search name', hintStyle: TextStyle(color: Colors.green), suffixIcon: Icon(Icons.search)),
                    cursorColor: Colors.green,
                  ),
                ),
                SizedBox(height: 10),
                FutureBuilder(
                  builder: (context, AsyncSnapshot<List<Leaderboard>> snapshot) {
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
                                title: Text('${snapshot.data?[index].name}', style: const TextStyle(
                                  color: Colors.lightGreen,
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.bold,
                                ),),
                                subtitle: Column(
                                  children: <Widget>[
                                    Text('Kota: ${snapshot.data?[index].city}', style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    Text('Alamat: ${snapshot.data?[index].address}', style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold,
                                    ),),
                                    TextButton(child: const Text("See Description", style: TextStyle(color : Colors.white),),
                                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.lightGreen)),
                                      onPressed: (){
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
                                      },
                                    )
                                  ],
                                )


                            )
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
          )
      ),
    );
  }
}