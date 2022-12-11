import 'package:wazzt/modules/forum/addQuestion.dart';
import 'package:wazzt/modules/forum/utils/fetch.dart';
import 'package:wazzt/modules/forum/models/forum_model.dart';
import 'package:wazzt/widget/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';

class ForumPage extends StatefulWidget {
  const ForumPage({super.key});
  @override
  _ForumPageState createState() => _ForumPageState();
}

class _ForumPageState extends State<ForumPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Forum FAQ'),
      ),
      drawer: buildDrawer(context),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              Color.fromARGB(255, 166, 238, 194),
              Color.fromARGB(255, 255, 255, 255),
            ],
          ),
        ),
        child: FutureBuilder(
          future: fetch(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Belum Ada Forum FAQ",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => GFAccordion(
                      content: "${snapshot.data![index].fields.body}",
                      titleChild: Row(
                        children: [
                          Image.network(
                              "https://cdn-icons-png.flaticon.com/512/1179/1179267.png",
                              height: 35,
                              fit: BoxFit.fill),
                          Text(
                            "${snapshot.data![index].fields.title}",
                            style: const TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                );
              }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyFormPage(),
              )); // Add your onPressed code here!
        },
        label: const Text('Tambahkan Pertanyaan'),
        icon: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 102, 243, 193),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
