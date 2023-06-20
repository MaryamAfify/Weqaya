import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;

import '../history_lab.dart';
class apiviewpatients {
  static Future<List<patientslist>> fetchPatientList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');


    final response = await http.get(Uri.parse(
        'http://hadyahmed-001-site1.ctempurl.com/api/Lab/GetLabPatient/GetLabPatient'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },

    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => patientslist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient list');
    }
  }
  static Future<void> confirmpatient(int patientid, String result) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.post(
      Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Lab/PostLabResults/LabResults'
          '?patientId=$patientid&results=$result'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    if (response.statusCode == 200) {
      print("Success");
       Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT, // Duration of the toast
          gravity: ToastGravity.BOTTOM, // Position of the toast message
          backgroundColor: Colors.grey, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size of the toast message
        );
    } else {
      print(patientid);
      throw Exception('Failed to load patient list');
    }
  }
  static Future<void> deleteBookedDoctor(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final url = 'http://hadyahmed-001-site1.ctempurl.com/api/Lab/DeletePatientFromLabDb?id=$id'; // Replace with your API endpoint

    try {
      final response = await http.delete(Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },

      );
      if (response.statusCode == 200) {
        // Data successfully deleted
        print('Data deleted successfully');
 Navigator.of(context).push(MaterialPageRoute(builder: (context){
   return myPatients_lab_history();
 }));

      } else {
        // Error deleting data
        print('Failed to delete data. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during delete request
      print('Failed to delete data. Exception: $e');
    }
  }
}
class patientslist {
  final String name;
  final String phoneNumber;
  final int price;
  final String testsOrRisks;
  final int statusNum;
  final int id;
  final String result;

  const patientslist({
    required this.name,
    required this.phoneNumber,
    required this.price,
    required this.testsOrRisks,
    required this.statusNum,
    required this.id,
    required this.result
  });

  factory patientslist.fromJson(Map<String, dynamic> json) {
    return patientslist(
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