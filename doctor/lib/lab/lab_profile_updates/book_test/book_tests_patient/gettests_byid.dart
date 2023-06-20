import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Apilabtestsforpatient {
  static Future<List<Test>> getLabTestsforpatient(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
      Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetLabTests/GetLabTests''?labId=$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      print("Lab tests data fetched successfully!");
      List<dynamic> jsonData = json.decode(response.body);
      List<Test> tests = jsonData.map((item) => Test.fromJson(item)).toList();
      return tests;
    } else {
      throw Exception('Failed to get Lab tests data');
    }
  }
}

class Test {
  final int idtest;
  final String name;
  final int  price;

  Test({
    required this.name,
    required this.price, required this.idtest});

  factory Test.fromJson(Map<String, dynamic> json) {
    return Test(
      name: json['testsAvailable'] ?? '', // Provide a default value when it's null
      price: json['testPrice'] ?? 0,
      idtest: json['id'] ??0 // Provide a default value when it's null
    );
  }
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Test && other.name == name && other.price == price;
  }

  @override
  int get hashCode => name.hashCode ^ price.hashCode;
}