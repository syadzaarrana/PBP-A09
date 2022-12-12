import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/modules/forum/utils/fetch.dart';
import 'package:wazzt/modules/tukar_poin/form/voucher_form.dart';
import 'package:wazzt/modules/tukar_poin/models/voucher_model.dart';
import 'package:wazzt/widget/Drawer.dart';
import '../account_auth/utils/cookie_request.dart';

class TukarPoinPage extends StatefulWidget {
  const TukarPoinPage({Key? key}) : super(key: key);

  @override
  State<TukarPoinPage> createState() => _TukarPoinState();
}

class _TukarPoinState extends State<TukarPoinPage> {
  @override
  Widget build(BuildContext context) {
    final _request = Provider.of<CookieRequest>(context, listen: false);

    return Scaffold(
      appBar: _request.is_bank
          ? AppBar(
              title: const Text('Voucher'),
              actions: <Widget>[
                IconButton(
                  icon: const Icon(Icons.add),
                  tooltip: 'Add Voucher',
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FormVoucher()));
                  },
                )
              ],
            )
          : AppBar(
            title: const Text('Voucher'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const FormVoucher()));
                  },
                child: const Text("My Voucher",
                  style: TextStyle(color:Colors.white),
                ),
              )
            ],
          ),
      drawer: buildDrawer(context),
      body: Container(
        child: FutureBuilder(
          future: fetch(),
          builder: (context, AsyncSnapshot snapshot){
            if (snapshot.data == null){
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
      
    );
  }
}
