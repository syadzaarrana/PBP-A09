import 'package:flutter/material.dart';

import 'cookie_request.dart';

// final request = Provider.of<CookieRequest>(context, listen: false);

Future<void> logout(BuildContext context, CookieRequest request) async {
  //const url = "http://127.0.0.1:8000/auth/logout_flutter/";
  // const url = "http://10.0.2.2:8000/authentication/logout_flutter/";

  const url = "https://wazzt.up.railway.app/authentication/logout_flutter/";

  final response = await request.logoutAccount(url);
  print(request.loggedIn);
  if (response["status"] == "loggedOut") {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Successfully logged out!"),
    ));
  } else {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("An error occured, please try again."),
    ));
  }
}
