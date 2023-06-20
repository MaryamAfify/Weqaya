import 'dart:convert';
import 'package:flutter/material.dart';

import '../lab_profile_updates/screens/api_for_update/get_lab_profile_class.dart';
import '../lab_search/api_lab_search/lab.dart';
import 'package:http/http.dart'as http;
class apiprofile{
static Future<labprofile?> getLabProfileByID(int id) async {
final String apiUrl =
'http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetLabById/GetLabById'
'?id=$id';

try {
final response = await http.get(Uri.parse(apiUrl));

if (response.statusCode == 200) {
//print(response.body);
final Map<String, dynamic> jsonResponse = json.decode(response.body);
return labprofile.fromJson(jsonResponse);
} else {
print(
'Failed to load doctor profile with status code: ${response.statusCode}');
return null;
}
} catch (e) {
print('Error: $e');
return null;
}
}}