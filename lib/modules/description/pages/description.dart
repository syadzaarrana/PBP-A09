import 'package:flutter/material.dart';
import 'package:wazzt/modules/description/utils/fetch.dart';
import 'package:wazzt/modules/description/pages/description_detail.dart';
import 'package:wazzt/modules/sumbangan/sumbangan.dart';

class DescriptionPage extends StatefulWidget {
  DescriptionPage(
      {super.key,
      required this.id,
      required this.name,
      required this.city,
      required this.email});

  final int id;
  final String name;
  final String city;
  final String email;

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green.shade50,
      appBar: AppBar(
        title: const Text('Waste Bank Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(17),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(7),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: const Icon(
                        Icons.info_outline,
                        color: Colors.green,
                        size: 30,
                      ),
                      title: Text(widget.name),
                      subtitle: Text("${widget.city} - ${widget.email}"),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        TextButton(
                          child: const Text('Donate Waste'),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => BuatSumbanganPage(
                                      id_bank_sampah: widget.id),
                                ));
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: FutureBuilder(
                  future: fetchDescription(widget.id),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) {
                      return const Center(child: CircularProgressIndicator());
                    } else {
                      if (!snapshot.hasData) {
                        return Column(
                          children: const [
                            Text(
                              "Empty",
                              style: TextStyle(
                                  color: Color(0xff59A5D8), fontSize: 20),
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
                              itemBuilder: (_, index) => Container(
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 13, vertical: 4),
                                    child: InkWell(
                                      splashColor:
                                          Colors.greenAccent.withAlpha(30),
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => DetailPage(
                                                  title: snapshot
                                                      .data![index].title,
                                                  date: snapshot
                                                      .data![index].date,
                                                  image: snapshot
                                                      .data![index].image,
                                                  desc: snapshot.data![index]
                                                      .description)),
                                        );
                                      },
                                      child: Card(
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Container(
                                          height: 250,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                              color: Colors.green.shade400,
                                              borderRadius:
                                                  BorderRadius.circular(15),
                                              image: DecorationImage(
                                                opacity: 0.5,
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  "https://wazzt.up.railway.app/media/${snapshot.data![index].image}",
                                                ),
                                              )),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                top: 20,
                                                bottom: 25,
                                                left: 25,
                                                right: 25),
                                            child: Column(
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  alignment: Alignment.topRight,
                                                  child: Text(
                                                    snapshot.data![index].date,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: const TextStyle(
                                                        fontSize: 10,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                                const Spacer(),
                                                Column(
                                                  children: [
                                                    Text(
                                                      snapshot
                                                          .data![index].title,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          letterSpacing: 2,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 15,
                                                          color: Colors.white),
                                                    ),
                                                    const SizedBox(height: 5),
                                                    Text(
                                                      snapshot.data![index]
                                                          .description,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 10),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )),
                        );
                      }
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
