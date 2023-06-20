import 'dart:convert';
import 'dart:typed_data';

class Patient {
  final String name;
  final String phonenumber;
  //final DateTime patientAppoinment;

  // final Uint8List photo;

  Patient({
    required this.name,
    required this.phonenumber,
    //required this.patientAppoinment,

    //  required this.photo,
    // required this.doctorpatients,
  });

  factory Patient.fromJson(Map<String, dynamic> jsonn) {
    return Patient(name: jsonn['name'], phonenumber: jsonn['phoneNumber'], //patientAppoinment: DateTime.parse(jsonn['patientAppointment']),
 );
    // doctorpatients: jsonn['doctorPatients']);
  }
}
