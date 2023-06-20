import 'dart:convert';
import 'dart:typed_data';
class labprofile {
  //final String id;
  final String name;
  final String labdescription;
 final String street;
 // final String photo;
  final String area;
  final Uint8List? photo;
  final int id;

  labprofile({
//    required this.id,
    required this.name,
  required this.area,
  required this.street,
  required this.labdescription,
 required this.photo,
    required this.id
  }
  );

  factory labprofile.fromJson(Map<String, dynamic> json) {
    String? base64Image = json['photo'];
    Uint8List? photo;
    if (base64Image != null) {
      photo = base64Decode(base64Image);
    }
    return labprofile(
   //   id: json['id'],
      name: json['name'],
      labdescription: json['labDescript'],
    area: json['area'],
      street: json['streetAddress'],
      photo: photo,
      id: json['id']
    );
  }
}