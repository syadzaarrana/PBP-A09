import 'package:wazzt/modules/forum/addQuestion.dart';
import 'package:wazzt/modules/forum/utils/fetch.dart';
import 'package:wazzt/modules/forum/models/forum_model.dart';
import 'package:wazzt/widget/Drawer.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:wazzt/modules/forum/forum.dart';

class ForumDetail extends StatelessWidget {
  const ForumDetail({super.key, required this.forum});

  final Forum forum;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Response'),
        leading: IconButton(
          onPressed: () {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ForumPage(),
                ));
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(children: [
        Container(
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
        ),
        Card(
          margin: EdgeInsets.all(36),
          elevation: 20,
          color: Color.fromARGB(255, 117, 210, 177),
          shape: RoundedRectangleBorder(
              side: BorderSide(color: Color.fromARGB(255, 1, 36, 70), width: 3),
              borderRadius: BorderRadius.all(Radius.circular(15))),
          shadowColor: Color.fromARGB(255, 159, 231, 186),
          child: Column(
            children: <Widget>[
              Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    forum.fields.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 30),
                  ListTile(
                    leading: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/4403/4403512.png",
                        height: 30,
                        fit: BoxFit.fill),
                    title: const Text(
                      'Question: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      forum.fields.body,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  ListTile(
                    leading: Image.network(
                        "https://cdn-icons-png.flaticon.com/512/2068/2068627.png",
                        height: 30,
                        fit: BoxFit.fill),
                    title: const Text(
                      'Asked by: ',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      forum.fields.username,
                      style: const TextStyle(fontSize: 16),
                    ),
                    dense: true,
                  ),
                  ListTile(
                      title: const Padding(
                        padding: EdgeInsets.only(bottom: 10.0),
                        child: Text(
                          'Admin Answer: ',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ),
                      dense: true,
                      subtitle: forum.fields.adminAnswer == ""
                          ? Text(
                              "There is no response",
                              style: const TextStyle(
                                  fontSize: 25, color: Colors.black),
                            )
                          : Text(
                              forum.fields.adminAnswer,
                              style: const TextStyle(
                                  fontSize: 18, color: Colors.black),
                            )),
                ],
              ),
              const Spacer(),
              ElevatedButton(
                child: Text('Go Back'),
                style: ElevatedButton.styleFrom(
                    padding:
                        EdgeInsets.symmetric(horizontal: 70.0, vertical: 20.0),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0)),
                    primary: Color.fromARGB(255, 102, 243, 193)),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const ForumPage()),
                  );
                },
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ]),
    );
  }
}
