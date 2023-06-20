import 'dart:convert';
import 'dart:typed_data';

class Doctor2 {
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

  final int id;
  final Uint8List? photo;
  List<DateTime> appoinments;
  final String education;
  // final Uint8List photo;

  Doctor2(
      {required this.name,
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
      required this.appoinments,
      required this.education

      //  required this.photo,
      // required this.doctorpatients,
      });

  factory Doctor2.fromJson(Map<String, dynamic> jsonn) {
    String? base64Image = jsonn['photo'];
    Uint8List? photo;
    if (base64Image != null) {
      photo = base64Decode(base64Image);
    }
    List<dynamic> appointmentsJson = jsonn['appointments'];
    // Use the 'map' function to convert each appointment string to a DateTime object
    List<DateTime> appointments = appointmentsJson
        .map((appointment) => DateTime.parse(appointment as String))
        .toList();
    return Doctor2(
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
      photo: photo,
      appoinments: appointments,
      education: jsonn['education']
      //  photo: Uint8List.fromList(jsonn['photo']),
    );
    // doctorpatients: jsonn['doctorPatients']);
  }
}
