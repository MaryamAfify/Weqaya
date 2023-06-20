import 'dart:convert';

import 'package:doctor/lab/lab_review/api_lab_review/review.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart';

class apireviews {
  static Future postReview(String review, int id, int reviewStar) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/PostLabReviews/LabReviews'
        '?id=$id&reviews=$reviewStar&comments=$review';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
        // body: jsonEncode({'appointments': formattedDate}),
      );
      if (response.statusCode == 200) {
        {
          Fluttertoast.showToast(
            msg: 'Thank you for your rating',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            backgroundColor: Colors.grey[800],
            textColor: Colors.white,
            fontSize: 16.0,
          );
        }
      } else {
        // Error in API call
        print('Error posting review: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      //print(token);
      print('Exception: $e');
    }
  }

  // static Future<List<Review>> fetchReviews() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? token = pref.getString('token');

  //   final response = await http.get(
  //     Uri.parse(
  //         'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/ViewDoctorReviews/ViewDoctorReviews'),
  //     headers: {
  //       'Content-Type': 'application/json;charset=utf-8',
  //       'Authorization': 'Bearer $token'
  //     },
  //   );

  //   if (response.statusCode == 200) {
  //     print('Docter Reviews geted!!');
  //     print(response.body);
  //    final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //   final List<dynamic> reviewsJson = List<dynamic>.from(jsonResponse['reviews']);
  //   List<Review> reviews = reviewsJson.map((json) => Review.fromJson(json)).toList();
  //   return reviews;
  //   } else {
  //     throw Exception('Failed to load reviews');
  //   }
  // }

  static Future<Map<String, dynamic>> fetchReviews() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Lab/ViewLabReviews/ViewLabReviews'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print('Doctor Reviews retrieved!');
      print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> reviewsJson = List<dynamic>.from(jsonResponse['reviews']);
      List<Reviewlab> reviews =
          reviewsJson.map((json) => Reviewlab.fromJson(json)).toList();
     // double avg = jsonResponse['avg'];
      Map<String, dynamic> result = {
        'reviews': reviews,
       // 'avg': avg,
      };
      return result;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  static Future<Map<String, dynamic>> fetchReviewsbyIDLab(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetLabReviewsById/GetLabReviewsById'
          '?id=$id'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print('Doctor Reviews retrieved!');
      print(response.body);
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      List<dynamic> reviewsJson = List<dynamic>.from(jsonResponse['reviews']);
      List<Reviewlab> reviews =
          reviewsJson.map((json) => Reviewlab.fromJson(json)).toList();

      Map<String, dynamic> result = {
        'reviews': reviews,
      };
      return result;
    } else {
      throw Exception('Failed to load reviews');
    }
  }
}
