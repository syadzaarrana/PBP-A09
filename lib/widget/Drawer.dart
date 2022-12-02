import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wazzt/main.dart';

import '../modules/account_auth/pages/login_page.dart';
import '../modules/account_auth/utils/cookie_request.dart';
import '../modules/account_auth/utils/logout.dart';

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
      ],
    ),
  );
}
