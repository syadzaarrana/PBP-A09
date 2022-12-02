import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../widget/Drawer.dart';
import '../utils/cookie_request.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);
  @override
  _State createState() => _State();
}

class _State extends State<AuthPage> {
  CookieRequest request = CookieRequest();
  String email = "";
  bool is_regular = false;
  bool is_bank = false;
  int id = 0;
  bool loggedIn = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final _request = Provider.of<CookieRequest>(context, listen: false);

      if (!_request.loggedIn) {
      } else {
        setState(() {
          request = _request;
          loggedIn = _request.loggedIn;
          // email = _request.email;
          is_bank = _request.is_bank;
          is_regular = _request.is_regular;
          id = _request.id;
        });
      }
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: (is_regular ?
            const Text('asikk udah masuk nih regular :D') :
            const Text('asikk udah masuk nih bank :D')),
        ),
        drawer: buildDrawer(context),
        body: Padding(
          padding: const EdgeInsets.all(30),
        ));
  }
}

//   @override
//   State<StatefulWidget> createState() {
//     // TODO: implement createState
//     throw UnimplementedError();
//   }
// }
