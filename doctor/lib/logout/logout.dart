import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../auth_screen/login.dart';


class Auth {
  static Future<void> logout(BuildContext context) async {
    // Clear user session or authentication tokens
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    // Perform additional cleanup tasks specific to your app
    // For example, you can delete cached data, reset state variables, etc.

    // Navigate to the login screen
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => LoginPage()),
            (Route<dynamic> route) => false);
  }
}