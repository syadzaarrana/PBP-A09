import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/main.dart';

import '../modules/account_auth/pages/login_page.dart';
import '../modules/account_auth/utils/cookie_request.dart';
import '../modules/account_auth/utils/logout.dart';
import '../modules/leaderboard/leaderboard.dart';
import '../modules/profile/pages/cobaShowBank.dart';
import '../modules/profile/pages/cobaShowReg.dart';
import '../modules/profile/pages/editProfilePage.dart';
import '../modules/sumbangan/sumbangan.dart';
import '../modules/sumbangan/history.dart';

Drawer buildDrawer(BuildContext context) {
  final _request = Provider.of<CookieRequest>(context, listen: false);

  return Drawer(
    child: Column(
      children: [
        // Menambahkan clickable menu

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
        Visibility(
          visible: _request.is_regular,
          child:
             ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowProfilePage((_request.id).toString())));
              }
        ),
        ),

         Visibility(
          visible: _request.is_bank,
          child:
             ListTile(
              title: const Text('Profile'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ShowBankPage((_request.id).toString())));
              }
        ),
        ),
         ListTile(
            title: const Text('Edit Profile Reg (Temporary)'),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfilePage((_request.id).toString())));
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
        ListTile(
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
        _request.loggedIn
            ? ListTile(
          title: const Text('Logout'),
          onTap: () {
            logout(context, _request);
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
            
      ],
    ),
  );
}
