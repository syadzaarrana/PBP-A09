import 'package:flutter/material.dart';
import 'package:wazzt/modules/description/utils/fetch.dart';

class DescriptionPage extends StatefulWidget {
  const DescriptionPage({super.key});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail'),
      ),
      body: FutureBuilder(
          future: fetchDescription(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (!snapshot.hasData) {
                return Column(
                  children: const [
                    Text(
                      "Empty",
                      style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                    ),
                    SizedBox(height: 8),
                  ],
                );
              } else {
                return Padding(
                  padding: const EdgeInsets.only(top: 15, bottom: 15),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (_, index) => Padding(
                            padding: const EdgeInsets.all(20),
                            child: Column(
                              children: [
                                Text(
                                  snapshot.data![index].title,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 35),
                                Text(
                                  snapshot.data![index].date.toString(),
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 35),
                                Text(
                                  snapshot.data![index].description,
                                  style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 35),
                                Image.network(
                                  "https://wazzt.up.railway.app/media/${snapshot.data![index].image}",
                                  width: 100,
                                  height: 100,
                                ),
                                const Spacer(),
                                ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                        minimumSize: const Size.fromHeight(45)),
                                    onPressed: (() => Navigator.pop(context)),
                                    child: const Text(
                                      'Back',
                                      style: TextStyle(fontSize: 14),
                                    ))
                              ],
                            ),
                          )),
                );
              }
            }
          }),
    );
  }
}
