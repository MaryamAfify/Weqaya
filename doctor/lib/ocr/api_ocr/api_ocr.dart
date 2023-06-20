import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class Apiocr {
  static Future<List<ocr>> getocr() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
      Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Patient/ViewPatientTestsOcr/ViewPatientTestsOcr'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {

      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => ocr.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  static void getocrtestsbutton(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
      Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Patient/RecommendTests/Recommendation'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
    //  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    //    return checkups();
    //  }));

    //  await getocr();
    } else {
      final errorMessage = response.body;
      print('API Error: $errorMessage');
      throw Exception('API Error: $errorMessage');
    }
  }
}

class ocr {
  final String name;

  ocr({
    required this.name,
  });

  factory ocr.fromJson(Map<String, dynamic> jsonn) {
    return ocr(
      name: jsonn['testName'],
    );
  }
}