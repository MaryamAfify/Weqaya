import 'dart:convert';
import 'dart:typed_data';

class lab {
  final String name;
  final String area;
  final Uint8List? photo;
  final int id;
  final double avg;

  lab({
    required this.name,
    required this.area,
    required this.photo,
    required this.id,
    required this.avg,
  });

  factory lab.fromJson(Map<String, dynamic> json) {
    String? base64Image = json['photo'];
    Uint8List? photo;
    if (base64Image != null) {
      photo = base64Decode(base64Image);
    }
    return lab(
      name: json['name'],
      area: json['area'],
      photo: photo,
      id: json['id'],
      avg: (json['avg'] ?? 0).toDouble(),
    );
  }
}
