import 'dart:convert';
import 'package:http/http.dart' as http;

class Review {
  final String text;
  final int rating;
  final String name;
  

  Review({required this.text, required this.rating, required this.name,});

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      text: json['reviewsComments'],
      rating: json['reviews'],
      name: json['name'],
     
    );
  }
}
