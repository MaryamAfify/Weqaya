import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class apiviewpatientshistory{
  static Future<List<patientslisthistory>> fetchPatientList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');


    final response = await http.get(Uri.parse(
        'http://hadyahmed-001-site1.ctempurl.com/api/Lab/GetLabPatientHistory/GetLabPatientHistory'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },

    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => patientslisthistory.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient list');
    }
  }
}
class patientslisthistory {
  final String name;
  final String phoneNumber;
  final int price;
  final String testsOrRisks;
  final int statusNum;
  final int id;
  final String result;

  const patientslisthistory({
    required this.name,
    required this.phoneNumber,
    required this.price,
    required this.testsOrRisks,
    required this.statusNum,
    required this.id,
    required this.result
  });

  factory patientslisthistory.fromJson(Map<String, dynamic> json) {
    return patientslisthistory(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      price: json['price'],
      testsOrRisks: json['testsOrRisks'],
      statusNum: json['statusNum'],
      id: json['patientId'],
    result: json['results']
    );
  }
}