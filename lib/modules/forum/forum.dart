import 'package:wazzt/modules/forum/addQuestion.dart';
import 'package:wazzt/modules/forum/answer.dart';
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
      resizeToAvoidBottomInset: false,
      drawer: buildDrawer(context),
      body: Container(
        height: double.infinity,
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "FAQ Question:",
                style: const TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Image.network(
                  "https://cdn-icons-png.flaticon.com/128/3649/3649770.png",
                  height: 48,
                  fit: BoxFit.fill),
              SizedBox(
                height: 25,
              ),
              FutureBuilder(
                future: fetch(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.data == null) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (!snapshot.hasData) {
                      return Column(
                        children: const [
                          Text(
                            "There is no question in FAQ",
                            style: TextStyle(
                                color: Color(0xff59A5D8), fontSize: 20),
                          ),
                          SizedBox(height: 8),
                        ],
                      );
                    } else {
                      return ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (_, index) => GFAccordion(
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
                            ),
                            contentChild: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Authored by: " +
                                      "${snapshot.data![index].fields.username}" +
                                      " ",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Created at: " +
                                      "${snapshot.data![index].fields.createdAt}",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  "Question: ",
                                  style: const TextStyle(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "${snapshot.data![index].fields.body}",
                                  style: const TextStyle(
                                    fontSize: 20.0,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                ElevatedButton(
                                  child: Text('Admin Response'),
                                  style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0)),
                                      primary:
                                          Color.fromARGB(255, 102, 243, 193)),
                                  onPressed: () {
                                    Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => ForumDetail(
                                              forum: snapshot.data![index])),
                                    );
                                  },
                                ),
                              ],
                            )),
                      );
                    }
                  }
                },
              ),
            ],
          ),
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
        label: const Text('Add your Question to FAQ'),
        icon: const Icon(Icons.add),
        backgroundColor: Color.fromARGB(255, 102, 243, 193),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
