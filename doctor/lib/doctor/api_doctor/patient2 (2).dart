import 'dart:convert';
import 'dart:typed_data';

class Patient2 {
  final String name;
  final String phonenumber;
  final DateTime patientAppoinment;
  final int id;
  final int age;
  final int statusNum;

  // final Uint8List photo;

  Patient2(
      {required this.name,
      required this.phonenumber,
      required this.patientAppoinment,
      required this.id,
      required this.age,
      required this.statusNum

      //  required this.photo,
      // required this.doctorpatients,
      });

  factory Patient2.fromJson(Map<String, dynamic> jsonn) {
    return Patient2(
        name: jsonn['name'],
        phonenumber: jsonn['phoneNumber'],
        patientAppoinment: DateTime.parse(jsonn['patientAppointment']),
        id: jsonn['id'],
        statusNum: jsonn['statusNum'],
        age: jsonn['age'],
        
        
        );
    // doctorpatients: jsonn['doctorPatients']);
  }
}
