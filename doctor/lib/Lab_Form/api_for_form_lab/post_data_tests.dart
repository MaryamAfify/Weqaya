import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APITests {
  //static const String _base_Url = 'http://hadyahmed-001-site1.ctempurl.com/api';
  static Future<http.Response> UserForm(int id, double price,) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    //logic to send data to server
    //https://e09f-102-46-3-190.ngrok-free.app/api/Account/Register

    final http.Response response = await http.post(
        Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Lab/ChooseTest/ChooseTests''?testId=$id&price=$price'),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
        }));
    if (response.statusCode == 200) {
      print("success");
    } else {
      print("No");
    }
    return response;
  }
}