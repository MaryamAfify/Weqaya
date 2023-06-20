import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
class apiviewlabs {
  static Future<List<labslist>> fetchBookedDoctors() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    try {
      final response = await http.get(
        Uri.parse(
            'http://hadyahmed-001-site1.ctempurl.com/api/Patient/ViewLabsAssigned/ViewLabsAssigned'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => labslist.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch doctors');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }
  static Future<List<labslist>> fetchHistoryLabList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');


    final response = await http.get(Uri.parse(
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/ViewLabsHistory/ViewLabsHistory'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },

    );

    if (response.statusCode == 200) {
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => labslist.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient list');
    }
  }
  static Future<void> deleteBookedDoctor(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final url = 'http://hadyahmed-001-site1.ctempurl.com/api/Patient/DeleteAssignedLab/DeleteAssignedLab?id=$id'; // Replace with your API endpoint

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
        Fluttertoast.showToast(
          msg: 'Cancaled successfully!', // Message to be displayed
          toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
          gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
          timeInSecForIosWeb: 3,
          backgroundColor: Colors.grey[700], // Background color of the toast
          textColor: Colors.white, // Text color of the toast
        );

      } else {
        // Error deleting data
        print('Failed to delete data. Error: ${response.statusCode}');
        Fluttertoast.showToast(
          msg: 'Failed To Cancal!', // Message to be displayed
          toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
          timeInSecForIosWeb: 3,
          gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
          backgroundColor: Colors.grey[700], // Background color of the toast
          textColor: Colors.white, // Text color of the toast
        );
      }
    } catch (e) {
      // Exception occurred during delete request
      print('Failed to delete data. Exception: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to delete data. Exception: $e'),
          duration: Duration(seconds: 2), // Duration for which the toast should be visible
        ),
      );
    }
  }
}

class labslist {
  final String labname;
  final String testname;
  final int statusNum;
  final int price;
  final int testid;
  final int labid;
  final String area;
  final String result;
  final Uint8List? photo;
  const labslist({
    required this.labname,
    required this.price,
    required this.testname,
    required this.statusNum,
    required this.labid,
    required this.testid,
    required this.area,
    required this.result,
    required this.photo
  });

  factory labslist.fromJson(Map<String, dynamic> json) {
    String? base64Image = json['photo'];
    Uint8List? photo;
    if (base64Image != null) {
      photo = base64Decode(base64Image);
    }
    return labslist(
        labname: json['labName'],
        price: json['price'],
        testname: json['testName'],
        statusNum: json['statusNum'],
        labid: json['labId'],
        testid:json['testId'],
       area:json['area'],
    result: json['results'],
      photo: photo,
    );
  }
}