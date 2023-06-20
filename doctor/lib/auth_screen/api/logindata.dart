import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';

import '../../DoctorView/doctorForm.dart';
import '../../Lab_Form/Lab_Form.dart';
import '../../doctor/api_doctor/api.dart';
import '../../doctor/doctor_profile/doctor_profile.dart';
import '../../home_screen/homescreen.dart';
import '../../lab/lab_profile_updates/lab_profile_for_updates.dart';
import '../../recommendation_screen/form_screen.dart';
import '../registeration.dart';

void login(String email, password, BuildContext context) async {
  try {
    final http.Response response = await http.post(
        Uri.parse(
            "http://hadyahmed-001-site1.ctempurl.com/api/Account/Login/login"),
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8'
        },
        body: jsonEncode(
          <String, dynamic>{"email": email, "password": password},
        ));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('Login successfully');
      Fluttertoast.showToast(
        msg: 'login Successfully!', // Message to be displayed
        toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
        gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
        backgroundColor: Colors.grey[700], // Background color of the toast
        textColor: Colors.white, // Text color of the toast
      );
      //  Navigator.of(context ).push(MaterialPageRoute(builder: (context){
      //   return homescreen();
      // }));
      // NavigationService().navigateToScreen(homescreen());
      if (email.contains('@lab')) {
        pageLabRoute(data['token'], context);
      } else if (email.contains('@gmail')) {
        pagePatientRoute(data['token'], context);
      } else if (email.contains('@doctor')) {
        pageDoctorRoute(data['token'], context);
      }
    } else {
      print('failed');
      Fluttertoast.showToast(
        msg: 'Failed To Login!', // Message to be displayed
        toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
        gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
        backgroundColor: Colors.grey[700], // Background color of the toast
        textColor: Colors.white, // Text color of the toast
      );
    }
  } catch (e) {
    print(e.toString());
  }
}

void pagePatientRoute(String token, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('token', token);
  bool hasFilledForm = pref.getBool('filledForm') ?? false;
//  Navigator.of(context ).pushReplacement(MaterialPageRoute(builder: (context){
  //   return home();
  // }));
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
    return home();
  }));
}

void pageLabRoute(String token, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('token', token);

  try {
    await Api.checkStatusAndNavigateLab(context);
  } catch (e) {
    print('Error: $e');
    print("Error from login data");
  }
}

void pageDoctorRoute(String token, BuildContext context) async {
  SharedPreferences pref = await SharedPreferences.getInstance();
  await pref.setString('token', token);

  try {
    await Api.checkStatusAndNavigate(context);
  } catch (e) {
    print('Error: $e');
    print("Error from login data");
  }
}
