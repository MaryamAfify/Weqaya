import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';

import '../../lab/lab_profile_updates/lab_profile_for_updates.dart';

class ApiLab {

  static Future<http.Response> addDoctor(
    String name,
    String area,
    String streetAddress,
    String labDescript,
  //  num timeFrom,
   // num timeTo,
      BuildContext context,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.post(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Lab/AddLab/AddLab'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
       // 'timeFrom': timeFrom,
      //  'timeTo': timeTo,
        "name": name,
        "labDescript":labDescript ,
        "area": area,
        "streetAddress": streetAddress
      }),
    );
    if (response.statusCode == 200) {
      // print(response.body);
      print("ok!");
      await pref.setBool('filledForm', true);
      // final dynamic doctorJson = jsonDecode(response.body);
      // final Doctor doctor = Doctor.fromJson(doctorJson);
      // return doctor;
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){
        return lab_profile_for_updates();
      }));
    } else {
      throw Exception('Unexpected error occured!');
    }
    return response;
  }

// static Future<http.StreamedResponse> addDoctor(
//     File? pickedImage, // Add this parameter to receive the picked image
//     String name,
//     String area,
//     String speciality,
//     String streetAddress,
//     String education,
//     String subSpeciality,
//     num price,
//     String doctorInfo,
//     num timeFrom,
//     num timeTo,
//     num duration,
//   ) async {
//   SharedPreferences pref = await SharedPreferences.getInstance();
//   String? token = pref.getString('token');

//   // Create a MultipartRequest
//   var request = http.MultipartRequest(
//     'POST',
//     Uri.parse(
//         'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/AddDoctor/AddDoctor'),
//   );

//   // Add headers
//   request.headers.addAll(<String, String>{
//     'Content-Type': 'multipart/form-data',
//     'Authorization': 'Bearer $token'
//   });

//   // Add text fields
//   request.fields.addAll(<String, String>{
//     'name': name,
//     'speciality': speciality,
//     'education': education,
//     'price': price.toString(),
//     'doctorInfo': doctorInfo,
//     'subSpeciatlity': subSpeciality,
//     'timeFrom': timeFrom.toString(),
//     'timeTo': timeTo.toString(),
//     'duration': duration.toString(),
//     'area': area,
//     'streetAddress': streetAddress,
//   });

//   // Add the image file
//   request.files.add(await http.MultipartFile.fromPath(
//     'image', // This is the field name for the image
//     pickedImage!.path,
//     contentType: MediaType('image', 'jpg'), // Adjust the content type if needed
//   ));

//   // Send the request
//   final response = await request.send();

//   if (response.statusCode == 200) {
//     print("ok!");
//   } else {
//     throw Exception('Unexpected error occurred!');
//   }

//   return response;
// }
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
