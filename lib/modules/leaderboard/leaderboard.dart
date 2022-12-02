import 'package:http/http.dart' as http;
import 'package:wazzt/modules/leaderboard/models/leaderboard_model.dart';
import 'dart:convert';

import 'package:wazzt/main.dart';
import 'package:wazzt/modules/leaderboard/utils/fetch.dart';
import 'package:flutter/material.dart';
import 'package:wazzt/widget/Drawer.dart';

class LeaderboardPage extends StatefulWidget {
  const LeaderboardPage({Key? key}) : super(key: key);

  @override
  State<LeaderboardPage> createState() => _LeaderboardPageState();
}

class _LeaderboardPageState extends State<LeaderboardPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboard'),
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
                        "Belum ada user",
                        style: TextStyle(color: Color(0xff59A5D8), fontSize: 20),),
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
                              header: const Text('Leaderboard'),
                              columns: const [
                                DataColumn(label: Text('Nama')),
                                DataColumn(label: Text('Domisili')),
                                DataColumn(label: Text('Berat')),
                              ],
                              showCheckboxColumn: false,
                            ),
                          ]));
                }
              }
            }));
  }
  DataTableSource dataSource(List<Leaderboard> leaderboardList) =>
      MyData(dataList: leaderboardList);
}

class MyData extends DataTableSource {
  MyData({required this.dataList});
  final List<Leaderboard> dataList;
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
          Text(dataList[index].name),
        ),
        DataCell(
          Text(dataList[index].city),
        ),
        DataCell(
          Text(dataList[index].weight.toString()),
        ),
      ],
    );
  }
}

