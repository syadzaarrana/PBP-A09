import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/main.dart';

import '../modules/account_auth/pages/login_page.dart';
import '../modules/account_auth/utils/cookie_request.dart';
import '../modules/account_auth/utils/logout.dart';
import '../modules/leaderboard/leaderboard.dart';
import '../modules/profile/showProfilePage.dart';


Drawer buildDrawer(BuildContext context) {
  final _request = Provider.of<CookieRequest>(context, listen: false);

  return Drawer(
    child: Column(
      children: [
        // Menambahkan clickable menu
        _request.loggedIn
            ? ListTile(
          title: const Text('Logout'),
          onTap: () {
            logout(context, _request);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyHomePage(title: ""),
                ));
          },
        )
            : ListTile(
            title: const Text('Login'),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ));
            }),
        ListTile(
            title: const Text('Wazzt'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(title: ""),
              ));
            }
        ),
        ListTile(
          title: const Text('Forum'),
          //     onTap: () {
          //       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MyFormPage()),);
          //     }
        ),
        ListTile(
          title: const Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShowProfilePage()),);
              }
        ),
        ListTile(
            title: const Text('Leaderboard'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const LeaderboardPage()),);
            }
        ),
        ListTile(
          title: const Text('Tukar Poin'),
          //     onTap: () {
          //       Navigator.push(context, MaterialPageRoute(builder: (context) => const WatchListPage()),);
          //     }
        ),
        LListTile(
          title: const Text('Riwayat'),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()),);
              }
        ),
        ListTile(
            title: const Text('Donasi (Temporary)'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const BuatSumbanganPage()),);
            }
        ),
      ],
    ),
  );
}
