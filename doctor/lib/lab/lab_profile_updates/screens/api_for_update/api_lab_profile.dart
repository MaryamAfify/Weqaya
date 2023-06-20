import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import 'get_lab_profile_class.dart';

class Apilabprofile {
 static Future<labprofile> getLabProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
        Uri.parse(
            'http://hadyahmed-001-site1.ctempurl.com/api/Lab/GetCurrentLabProfile/GetCurrentLabProfile'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      print("Lab Data get successfully!");
      print(response.body);
      print(response.statusCode);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String? base64Image = jsonResponse['photo'];
      Uint8List? photo;
      if (base64Image != null) {
        photo = base64Decode(base64Image);
      }
      return labprofile(
        //   id: json['id'],
        name: jsonResponse['name'],
        labdescription: jsonResponse['labDescript'],
        area: jsonResponse['area'],
        street: jsonResponse['streetAddress'],
        photo: photo,
        id: jsonResponse['id'],
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get Lab data');
    }
  }
}