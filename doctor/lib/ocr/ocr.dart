import 'package:doctor/ocr/result/choose_lab.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'api_ocr/api_ocr.dart';

class ocr_test extends StatefulWidget {
  const ocr_test({Key? key}) : super(key: key);

  @override
  State<ocr_test> createState() => _ocr_testState();
}

class _ocr_testState extends State<ocr_test> {
  File? _image;
  final picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImageOCR1(
    File? image
  ) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');

    if (image == null) return;

    // Replace with your API endpoint and token
    String apiUrl = 'http://hadyahmed-001-site1.ctempurl.com/api/Patient/OCR';

    var request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.headers['Authorization'] = 'Bearer $token';
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var response = await request.send();

    if (response.statusCode == 200) {
      print(response.statusCode);
      print(response);
      print('Image uploaded successfully');

      Fluttertoast.showToast(
        msg: "Image uploaded successfully",
        toastLength: Toast.LENGTH_SHORT, // Duration of the toast
        gravity: ToastGravity.BOTTOM, // Position of the toast message
        backgroundColor: Colors.grey, // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );
    } else if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: "Failed to Upload image",
        toastLength: Toast.LENGTH_SHORT, // Duration of the toast
        gravity: ToastGravity.BOTTOM, // Position of the toast message
        backgroundColor: Colors.grey, // Background color of the toast
        textColor: Colors.white, // Text color of the toast
        fontSize: 16.0, // Font size of the toast message
      );
    } else {
      print('Image upload failed with status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Scan your Rosheta"),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text("Scan Your Prescription"),
                  SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    onTap: pickImage,
                    child: const Icon(Icons.camera_alt_outlined),
                  ),
                  ElevatedButton(
                      onPressed: () {
                        uploadImageOCR1(_image);
                      },
                      child: Text("upload")),
                  MaterialButton(
                    onPressed: () async {
                      await Apiocr.getocr();

                      await Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) {
                        return ocrtests();
                      }));
                    },
                    child: Text("get result"),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
