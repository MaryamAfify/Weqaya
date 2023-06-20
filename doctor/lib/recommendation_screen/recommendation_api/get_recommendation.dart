import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../checkups_by_recommendation/checkups.dart';

class Api {
  static Future<List<recomm>> getrecomm() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
      Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Patient/ViewPatientTests/ViewPatientTests'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => recomm.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected error occurred!');
    }
  }

  static void getrecommtestsbutton(BuildContext context) async {
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
      Navigator.of(context).push(MaterialPageRoute(builder: (context) {
        return checkups();
      }));

      await getrecomm();
    } else {
      final errorMessage = response.body;
      print('API Error: $errorMessage');
      throw Exception('API Error: $errorMessage');
    }
  }
}

class recomm {
  final String name;

  recomm({
    required this.name,
  });

  factory recomm.fromJson(Map<String, dynamic> jsonn) {
    return recomm(
      name: jsonn['testName'],
    );
  }
}