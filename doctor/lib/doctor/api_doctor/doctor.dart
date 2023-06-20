import 'dart:convert';
import 'dart:typed_data';

class Doctor {
  final String name;
  final String speciality;
  final String subSpeciality;
  num timeFrom;
  num timeTo;
  num duration;
  final num price;
  final String doctorInfo;
  final String area;
  final String streetAddress;
  final Uint8List? photo;
  final int id;
  final String education;

  Doctor({
    required this.name,
    required this.timeFrom,
    required this.timeTo,
    required this.duration,
    required this.subSpeciality,
    required this.speciality,
    required this.price,
    required this.doctorInfo,
    required this.id,
    required this.area,
    required this.streetAddress,
    required this.photo,
    required this.education
    // required this.doctorpatients,
  });

  factory Doctor.fromJson(Map<String, dynamic> jsonn) {
    String? base64Image = jsonn['photo'];
    Uint8List? photo;
    if (base64Image != null) {
      photo = base64Decode(base64Image);
    }
    return Doctor(
      id: jsonn['id'],
      timeFrom: jsonn['timeFrom'],
      timeTo: jsonn['timeTo'],
      duration: jsonn['duration'],
      name: jsonn['name'],
      speciality: jsonn['speciality'],
      area: jsonn['area'],
      price: jsonn['price'],
      doctorInfo: jsonn['doctorInfo'],
      streetAddress: jsonn['streetAddress'],
      subSpeciality: jsonn['subSpeciatlity'],
        education: jsonn['education'],
      photo: photo
    );
    // doctorpatients: jsonn['doctorPatients']);
  }
}
