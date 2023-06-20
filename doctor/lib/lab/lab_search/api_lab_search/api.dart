import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:convert';

import 'lab.dart';

class Apilab {
  static Future<List<lab>> getLabs(String test, String area) async {
    // String area = "Ghamra";
    // String Spec = "liver";
    // String name ="hady";
    var url = Uri.parse(
        'http://hadyahmed-001-site1.ctempurl.com/api/Lab/SearchLabs/SearchedLabs'
            '?test=$test&area=$area');
    //  'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/SearchDoctors/SearchedDoctors'
    // '?area=$area&speciality=$speciality');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      // print(speciality);
      //print(area);
      print(response.body);
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => lab.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }
}
