import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

class ApiLab {
  static Future uploadImage(File? image, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (image == null) return;

    // Replace with your API endpoint and token
    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Lab/AddPhoto/AddPhoto';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');

    } else {
      print('Image upload failed');
    }
  }
}