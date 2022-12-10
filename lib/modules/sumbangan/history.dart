import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'dart:convert';

import 'package:wazzt/main.dart';
import 'package:wazzt/modules/sumbangan/utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:wazzt/widget/Drawer.dart';
import '../account_auth/utils/cookie_request.dart';
import 'models/sumbangan_model.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {


  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    print(request.id);
    return Scaffold(
        appBar: AppBar(
          title: const Text('History'),
        ),
        drawer: buildDrawer(context),

        body: FutureBuilder(
            future: fetchHistory(request.id),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (snapshot.data!.length == 0) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Belum ada donasi",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20),),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            PaginatedDataTable(
                              source: dataSource(snapshot.data),
                              header: const Text('History'),
                              columns: const [
                                DataColumn(label: Text('Tanggal')),
                                DataColumn(label: Text('Bank Sampah')),
                                DataColumn(label: Text('Jenis Sampah')),
                                DataColumn(label: Text('Berat Sampah')),
                                DataColumn(label: Text('Poin')),
                              ],
                              showCheckboxColumn: false,
                            ),
                          ]));
                }
              }
            }));
  }
  DataTableSource dataSource(List<Donasi> donasiList) =>
      MyData(dataList: donasiList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  final List<Donasi> dataList;
  // Generate some made-up data

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => dataList.length;
  @override
  int get selectedRowCount => 0;
  @override
  DataRow getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(dataList[index].date.toString()),
        ),
        DataCell(
          Text(dataList[index].bank_sampah),
        ),
        DataCell(
          Text(dataList[index].jenis),
        ),
        DataCell(
          Text(dataList[index].berat.toString()),
        ),
        DataCell(
          Text(dataList[index].poin.toString()),
        ),
      ],
    );
  }
}

