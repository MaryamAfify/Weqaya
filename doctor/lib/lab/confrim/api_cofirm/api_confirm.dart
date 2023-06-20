import 'dart:convert';

import 'package:doctor/home_screen/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../home_screen/screens/navigation_in_patient_labs.dart';
import '../../../home_screen/screens/profile_screens/get_patient_data/get_api.dart';

class apibook {
  static Future PostBookedTest(
      int id, int idtest, int price, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/AssignLab/AssignLab'
        '?labId=$id&testId=$idtest&price=$price';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );

      if (response.statusCode == 200) {
        // Successful API call
        print('Post booked tests successfully');

        {
          Fluttertoast.showToast(
            msg: 'Booked Successfully',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[800],
            textColor: Colors.white,
            fontSize: 16.0,
          );
            Navigator.push(context, MaterialPageRoute(builder: (context) {
          return home();
        }));



        }
      } else if (response.statusCode == 400) {
        {
          Fluttertoast.showToast(
            msg: 'You already booked this test!!',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[800],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return home();
        }));
      } else {
        // Error in API call
        print('Error posting tests: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception: $e');
    }
  }

  static Future<List<Album>> fetchPatientList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/ViewPatients/ViewDoctorPatients'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Album.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient list');
    }
  }
}
