import 'dart:convert';
import 'package:http/http.dart' as http;

class Reviewlab {
  final String text;
  final int rating;
  final String name;
  

  Reviewlab({required this.text, required this.rating, required this.name,});

  factory Reviewlab.fromJson(Map<String, dynamic> json) {
    return Reviewlab(
      text: json['reviewsComments'],
      rating: json['reviews'],
      name: json['name'],
     
    );
  }
}
