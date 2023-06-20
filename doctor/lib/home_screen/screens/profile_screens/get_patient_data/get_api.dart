import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
 class api {
   static Future<Album> getPost() async {
     SharedPreferences pref = await SharedPreferences.getInstance();
     String? token = pref.getString('token');
     final response = await http.get(
       Uri.parse(
           'http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetPatientProfile/GetPatientProfile'),
       headers: <String, String>{
         'Content-Type': 'application/json;charset=utf-8',
         'Authorization': 'Bearer $token'
       },
     );

     if (response.statusCode == 200) {
       // If the server returned a 200 OK response, parse the JSON.
       print(response.body);
       return Album.fromJson(jsonDecode(response.body));
     } else {
       // If the server did not return a 200 OK response, throw an exception.
       print('Error: ${response.statusCode}');
       print('Response body: ${response.body}');
       throw Exception(
           'Failed to load album. Server returned ${response.statusCode}');
     }
   }
 }
class Album {
  final String name;
  final String phoneNumber;
  final num age;
  final num height;
  final num weight;
  final String diabetesRelatives;
  final String relativesWithHeartAttacksOrHighCholesterol;
  final String smoking;
  final String medicineForDiabetesOrPressure;
  final String highPressure;
  final String diabetes;

  const Album({
    required this.name,
    required this.phoneNumber,
    required this.age,
    required this.height,
    required this.weight,
    required this.diabetesRelatives,
    required this.relativesWithHeartAttacksOrHighCholesterol,
    required this.medicineForDiabetesOrPressure,
    required this.diabetes,
    required this.highPressure,
    required this.smoking,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      phoneNumber: json['phoneNumber'],
      age: json['age'],
      height: json['height'],
      weight: json['weight'],
      diabetesRelatives: json['diabetesRelatives'],
      relativesWithHeartAttacksOrHighCholesterol: json['relativesWithHeartAttacksOrHighColestrol'],
      smoking: json['smoking'],
      medicineForDiabetesOrPressure: json['medicineForDiabetesOrPressure'],
      highPressure: json['highPressure'],
      diabetes: json['diabetes'],
    );
  }
}