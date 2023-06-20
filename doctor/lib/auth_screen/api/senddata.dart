import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../recommendation_screen/form_screen.dart';
import '../login.dart';

class API {
  //static const String _base_Url = 'http://hadyahmed-001-site1.ctempurl.com/api';
  static Future<http.Response> createUser(
      String email,
      String password,
      String confirmPass,
      String firstName,
      String lastName,
      BuildContext context
      ) async {
    //logic to send data to server
    //https://e09f-102-46-3-190.ngrok-free.app/api/Account/Register

    final http.Response response = await http.post(
        Uri.parse("http://hadyahmed-001-site1.ctempurl.com/api/Account/Register"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: jsonEncode(<String, dynamic>{
          'email': email,
          'password': password,
          'confirmPassword': confirmPass,
          'firstName': firstName,
          'lastName': lastName,
        }));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(response.body);
      pagePatientFormRoute(data['token'], context);
      Fluttertoast.showToast(
        msg: 'registered successfully!', // Message to be displayed
        toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
        gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
        backgroundColor: Colors.grey[700], // Background color of the toast
        textColor: Colors.white, // Text color of the toast
      );
    } else {
      print("No");
      Fluttertoast.showToast(
        msg: 'registered Failed!', // Message to be displayed
        toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
        gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
        backgroundColor: Colors.grey[700], // Background color of the toast
        textColor: Colors.white, // Text color of the toast
      );
    }
    return response;
  }
}
void pagePatientFormRoute(String token, BuildContext context) async{
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('token', token);
  // Navigator.of(context ).push(MaterialPageRoute(builder: (context){
  //  return home();
  //}));
 Navigator.of(context ).pushReplacement(MaterialPageRoute(builder: (context){
    return recommendation_screen();
 }));
}