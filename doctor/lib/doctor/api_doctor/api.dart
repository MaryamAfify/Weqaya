import 'dart:typed_data';
import 'package:doctor/DoctorView/doctorForm.dart';
import 'package:doctor/Lab_Form/Lab_Form.dart';
import 'package:doctor/doctor/api_doctor/patient%20(1).dart';
import 'package:doctor/doctor/api_doctor/patient2%20(2).dart';
import 'package:doctor/doctor/api_doctor/review.dart';
import 'package:doctor/doctor/doctor_profile/doctor_profile.dart';
import 'package:doctor/doctor/doctorlist/navigationBarPatient.dart';
import 'package:doctor/doctor/doctorlist/pendingDoctors.dart';
import 'package:doctor/lab/lab_profile_updates/lab_profile_for_updates.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../../home_screen/homescreen.dart';
import '../doctorlist/completedDoctors.dart';
import 'doctor.dart';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'doctor2.dart';
import 'doctor3 (1).dart';
import 'doctor4.dart';

class Api {
  static Future<List<Doctor4>> getDoctors(
      String speciality, String area) async {
    // String area = "Ghamra";
    // String Spec = "liver";
    // String name ="hady";
    var url = Uri.parse(
        'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/SearchDoctors/SearchedDoctors'
        '?area=$area&specialty=$speciality');
    //  'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/SearchDoctors/SearchedDoctors'
    // '?area=$area&speciality=$speciality');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // print(speciality);
      //print(area);

      //print(response.body);

      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((item) => Doctor4.fromJson(item)).toList();
    } else {
      throw Exception('Unexpected error occured!');
    }
  }

  static Future<http.Response> addDoctor(
    String name,
    String area,
    String speciality,
    String streetAddress,
    String education,
    String subSpeciality,
    num price,
    String doctorInfo,
    num timeFrom,
    num timeTo,
    num duration,
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.post(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/AddDoctor/AddDoctor'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
      body: jsonEncode(<String, dynamic>{
        'name': name,
        'speciality': speciality,
        'education': education,
        'price': price,
        'doctorInfo': doctorInfo,
        'subSpeciatlity': subSpeciality,
        'timeFrom': timeFrom,
        'timeTo': timeTo,
        'duration': duration,
        'area': area,
        'streetAddress': streetAddress,
      }),
    );
    if (response.statusCode == 200) {
      print(response.body);
      print("ok!");
      // final dynamic doctorJson = jsonDecode(response.body);
      // final Doctor doctor = Doctor.fromJson(doctorJson);
      // return doctor;
    } else {
      throw Exception('Unexpected error occured!');
    }
    return response;
  }

  static Future postDates(List<DateTime> dates, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    String body = jsonEncode(dates.map((date) => date.toString()).toList());
    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/AppointmentAdd/Appointments';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
        body: body,
      );
      if (response.statusCode == 200) {
        // Successful API call
        print('Dates posted successfully!');

        // Navigator.push(
        //   context,
        //   MaterialPageRoute(builder: (context) => myProfile()),
        // );
      } else {
        // Error in API call
        print('Error posting dates: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print('Exception: $e');
    }
  }

  // static Future<Doctor> getDoctorProfile() async {
  //   SharedPreferences pref = await SharedPreferences.getInstance();
  //   String? token = pref.getString('token');
  //   final response = await http.get(
  //       Uri.parse(
  //           'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/GetCurrentDoctorProfile/GetDoctorProfile'),
  //       headers: {'Authorization': 'Bearer $token'});

  //   if (response.statusCode == 200) {
  //     print("Doctor Data get succefully!");
  //     print(response.body);
  //     print(response.statusCode);

  //     return Doctor.fromJson(jsonDecode(response.body));
  //   } else {
  //     // If the server did not return a 200 OK response,
  //     // then throw an exception.
  //     throw Exception('Failed to get doctor data');
  //   }
  // }

  static Future<Doctor> getDoctorProfile() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final response = await http.get(
        Uri.parse(
            'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/GetCurrentDoctorProfile/GetDoctorProfile'),
        headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      print("Doctor Data get successfully!");
      print(response.body);
      print(response.statusCode);

      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      String? base64Image = jsonResponse['photo'];
      Uint8List? photo;
      if (base64Image != null) {
        photo = base64Decode(base64Image);
      }

      return Doctor(
        id: jsonResponse['id'],
        timeFrom: jsonResponse['timeFrom'],
        timeTo: jsonResponse['timeTo'],
        duration: jsonResponse['duration'],
        name: jsonResponse['name'],
        speciality: jsonResponse['speciality'],
        area: jsonResponse['area'],
        price: jsonResponse['price'],
        doctorInfo: jsonResponse['doctorInfo'],
        streetAddress: jsonResponse['streetAddress'],
        subSpeciality: jsonResponse['subSpeciatlity'],
        photo: photo,
        education: jsonResponse['education'],
      );
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to get doctor data');
    }
  }

  static Future<List<DateTime>> getDates() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/GetDoctorAppointments/ViewDoctorAppointment';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        // Successful API call
        print('Dates fetched successfully!');

        // Parse the response body as a plain list of strings
        List<String> dateStrings = List<String>.from(jsonDecode(response.body));

        // Convert each date string to DateTime object
        List<DateTime> dates = dateStrings
            .map((dateString) => DateTime.parse(dateString))
            .toList();

        return dates;
      } else {
        // Error in API call
        print('Error fetching dates: ${response.statusCode}');
        return [];
      }
    } catch (e) {
      // Exception occurred
      print('Exception: $e');
      return [];
    }
  }

  static Future uploadImage(File? image, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (image == null) return;

    // Replace with your API endpoint and token
    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/AddPhoto/AddPhoto';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('file', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploaded successfully');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Data Added Successfully!!"),
          duration: Duration(
              seconds: 2), // Duration for which the toast should be visible
        ),
      );

      //  Navigator.push(
      //    context,
      //    MaterialPageRoute(builder: (context) => myProfile()),
      //   );
    } else {
      print('Image upload failed');
    }
  }

  static Future<Doctor2?> getDoctorProfileByID(int id) async {
    final String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetDoctorById/GetDoctorById'
        '?id=$id';

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        //print(response.body);
        print(response.body);
        final Map<String, dynamic> jsonResponse = json.decode(response.body);
        return Doctor2.fromJson(jsonResponse);
      } else {
        print(
            'Failed to load doctor profile with status code: ${response.statusCode}');
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  static Future<Patient> getPatientData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetPatientProfile/GetPatientProfile';

    final response = await http
        .get(Uri.parse(apiUrl), headers: {'Authorization': 'Bearer $token'});

    if (response.statusCode == 200) {
      print(response.body);
      print("Patient data get succefully");
      return Patient.fromJson(jsonDecode(response.body));
    } else {
      // If the server returns an error, throw an exception.
      throw Exception('Failed to load patient');
    }
  }

  static Future PostBookedDate(
      DateTime bookedDate, int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    String formattedDate = bookedDate.toString();

    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/AssignDoctor/AssignDoctor'
        '?doctorId=$id&appointments=$formattedDate';

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
        // Successful API call
        print('post booked date successfully');
        Fluttertoast.showToast(
          msg: "Booked Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
        );
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return home();
        }));
      } else if (response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: "You already have an appoinment",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
        );

        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return home();
        }));
      } else {
        // Error in API call
        print('Error posting dates: ${response.statusCode}');
        print(bookedDate);
      }
    } catch (e) {
      // Exception occurred
      print('Exception: $e');
    }
  }

  static Future<List<Patient2>> fetchPatientList() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/ViewPatients/ViewDoctorPatients'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Patient2.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient list');
    }
  }

  static Future<List<Doctor3>> fetchBookedDoctors() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    try {
      final response = await http.get(
        Uri.parse(
            'http://hadyahmed-001-site1.ctempurl.com/api/Patient/ViewDoctorsAssigned/ViewDoctorsAssigned'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Doctor3.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch doctors');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }

  static Future postNotesToPatient(String note, int patientID) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/PostDoctorNotes/DoctorNotes'
        '?patientId=$patientID&notes=$note';

    http: //hadyahmed-001-site1.ctempurl.com/api/Doctor/PostDoctorNotes/DoctorNotes?patientId=15&notes=completed%20visit

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
        print('notes posted!');
         Fluttertoast.showToast(
          msg: "Done",
          toastLength: Toast.LENGTH_SHORT, // Duration of the toast
          gravity: ToastGravity.BOTTOM, // Position of the toast message
          backgroundColor: Colors.grey, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size of the toast message
        );

        SnackBar(
          content: Text("Done"),
          duration: Duration(
              seconds: 2), // Duration for which the toast should be visible
        );
      } else {
        // Error in API call
        print('Error posting dates: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred
      print(token);
      print('Exception: $e');
    }
  }

  static Future<List<Patient2>> fetchPatientListCompleted() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/ViewPatientsHistory/ViewDoctorPatientsHistory'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> jsonList = jsonDecode(response.body);
      return jsonList.map((json) => Patient2.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load patient list');
    }
  }

  static Future<List<Doctor3>> fetchBookedDoctorsCompleted() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    try {
      final response = await http.get(
        Uri.parse(
            'http://hadyahmed-001-site1.ctempurl.com/api/Patient/ViewDoctorsHistory/ViewDoctorsHistory'),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        print(response.body);
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => Doctor3.fromJson(json)).toList();
      } else {
        throw Exception('Failed to fetch doctors');
      }
    } catch (error) {
      throw Exception('Failed to connect to the API: $error');
    }
  }

  static Future<void> deleteBookedDoctor(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final url =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/DeleteAssignedDoctor/DeleteAssignedDoctor'
        '?id=$id'; // Replace with your API endpoint

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return const pendingDoctors();
        }));
        Fluttertoast.showToast(
          msg: "Cancelled",
          toastLength: Toast.LENGTH_SHORT, // Duration of the toast
          gravity: ToastGravity.BOTTOM, // Position of the toast message
          backgroundColor: Colors.grey, // Background color of the toast
          textColor: Colors.white, // Text color of the toast
          fontSize: 16.0, // Font size of the toast message
        );

        print('Data deleted successfully');
        if (response.statusCode == 400) {
          Fluttertoast.showToast(
            msg: "Failed to cancel",
            toastLength: Toast.LENGTH_SHORT, // Duration of the toast
            gravity: ToastGravity.BOTTOM, // Position of the toast message
            backgroundColor: Colors.grey, // Background color of the toast
            textColor: Colors.white, // Text color of the toast
            fontSize: 16.0, // Font size of the toast message
          );
        }
      } else {
        // Error deleting data
        print('Failed to delete data. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during delete request
      print('Failed to delete data. Exception: $e');
    }
  }

  static Future<void> deleteBoookedPatient(int id, BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    final url =
        'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/DeletePatientFromDoctorDb'
        '?id=$id'; // Replace with your API endpoint

    try {
      final response = await http.delete(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token'
        },
      );
      if (response.statusCode == 200) {
        //  Navigator.push(context, MaterialPageRoute(builder: (context) {
        //    return const completed();
        //   }));
        // Data successfully deleted
        print('Data deleted successfully');
        

        
      } else {
        // Error deleting data
        print('Failed to delete data. Error: ${response.statusCode}');
      }
    } catch (e) {
      // Exception occurred during delete request
      print('Failed to delete data. Exception: $e');
    }
  }

  static Future postReview(String review, int id, int reviewStar) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    String apiUrl =
        'http://hadyahmed-001-site1.ctempurl.com/api/Patient/PostDoctorReviews/DoctorReviews'
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
        print('review posted!');
        Fluttertoast.showToast(
      msg: '"Thank you for your rating"', // The message to display in the toast
      toastLength: Toast.LENGTH_SHORT, // Duration for which the toast should be visible
      gravity: ToastGravity.BOTTOM, // Position of the toast message
      backgroundColor: Colors.grey, // Background color of the toast
      textColor: Colors.white, // Text color of the toast
      fontSize: 16.0, // Font size of the toast message
    );
        
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
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/ViewDoctorReviews/ViewDoctorReviews'),
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
      List<Review> reviews =
          reviewsJson.map((json) => Review.fromJson(json)).toList();
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

  static Future<Map<String, dynamic>> fetchReviewsbyID(int id) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Patient/GetDoctorReviewsById/GetDoctorReviewsById'
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
      List<Review> reviews =
          reviewsJson.map((json) => Review.fromJson(json)).toList();
     // double avg = jsonResponse['avg'];
      Map<String, dynamic> result = {
        'reviews': reviews,
        //'avg': avg,
      };
      return result;
    } else {
      throw Exception('Failed to load reviews');
    }
  }

  static Future<void> checkStatusAndNavigate(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/CheckUserData/CheckUserData'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final statusNum = responseData['statusNum'];

      if (statusNum == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => doctorForm()),
        );
        print(statusNum);
      } else if (statusNum == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => doctor_profile()),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Account Not Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
        );
      }
    } else {
      throw Exception('Failed to fetch statusNum');
    }
  }

  static Future<void> checkStatusAndNavigateLab(BuildContext context) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    final response = await http.get(
      Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Lab/CheckUserData/CheckUserData'),
      headers: {
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      final statusNum = responseData['statusNum'];

      if (statusNum == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Lab_Form()),
        );
        print(statusNum);
      } else if (statusNum == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => lab_profile_for_updates()),
        );
      } else {
        Fluttertoast.showToast(
          msg: "Account Not Found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey[700],
          textColor: Colors.white,
        );
      }
    } else {
      throw Exception('Failed to fetch statusNum');
    }
  }
}
