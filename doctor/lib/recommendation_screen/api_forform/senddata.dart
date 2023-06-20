import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../auth_screen/login.dart';

class APIPatient {
  //static const String _base_Url = 'http://hadyahmed-001-site1.ctempurl.com/api';
  static Future<http.Response> UserForm(String? Name,
      String? PhoneNumber,
      String? _smoking,
      String? age,
      String? _gender,
      String? _diabetes,
      String? _pressure,
      String? _diabetes_relatives,
      String? _relativeswithheartattacksorhighcolestrol,
      String? _medicinefordiabetesorpressure,
      String? height,
      String? weight,
      BuildContext context,) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    //logic to send data to server
    //https://e09f-102-46-3-190.ngrok-free.app/api/Account/Register

    final http.Response response = await http.post(
        Uri.parse(
            "http://hadyahmed-001-site1.ctempurl.com/api/Patient/CreatePatient/AddPatient"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(<String, dynamic>{
          "name": Name,
          "gender": _gender,
          "age": age,
          "weight": weight,
          "height": height,
          "phoneNumber": PhoneNumber,
          "diabetesRelatives": _diabetes_relatives,
          "relativesWithHeartAttacksOrHighColestrol": _relativeswithheartattacksorhighcolestrol,
          "smoking": _smoking,
          "medicineForDiabetesOrPressure": _medicinefordiabetesorpressure,
          "highPressure": _pressure,
          "diabetes": _diabetes,
          "LabReviews": [], // Provide a valid value for LabReviews field
          "DoctorReviews": [], // Provide a valid value for DoctorReviews field
          "PatientTestsOrRisksOcr": [], // Provide a valid value for PatientTestsOrRisksOcr field
          "patient": "", // Provide a value for patient field
        }));
    if (response.statusCode == 200) {
      // Successful response
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
        return LoginPage();
      }));
    } else {
      // Error response
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
    return response;
  }
}