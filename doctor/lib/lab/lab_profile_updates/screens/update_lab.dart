import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../Lab_Form/api_for_form_lab/api_lab_form.dart';
import '../../../styles/colors.dart';
import '../lab_profile_for_updates.dart';
import 'api_for_update/api_lab_profile.dart';
import 'api_for_update/get_lab_profile_class.dart';

class Update_lab extends StatefulWidget {
  @override
  State<Update_lab> createState() => _Update_labState();
}

class _Update_labState extends State<Update_lab> {
  List<String> cities = [
    'Giza',
    "Haram",
    "Faisal",
    "Dokki",
    "Mohandsen",
    "6 of October",
    "Nasr City",
    "Agouza",
    "New Cairo",
    "Abbasya",
    "Ghamra",
    "Ramses",
    "Down Town",
    "Kasr al Ainy",
    "10th of Ramadan",
    "Mosadak"
  ];
  String? selectedArea;
  File? _image;
  final picker = ImagePicker();
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutLabController = TextEditingController();
  TextEditingController streettController = TextEditingController();
  late Future<labprofile> _labProfileFuture;

  @override
  void initState() {
    super.initState();
    _fetchLabProfile();
  }

  Future<void> _fetchLabProfile() async {
    final api = Apilabprofile();
    _labProfileFuture = Apilabprofile.getLabProfile();
  }

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

  Future<void> updateData(BuildContext context) async {
    String newName = nameController.text;
    String newstreet = streettController.text;
    String newabout = aboutLabController.text;
    String newarea = selectedArea.toString();

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      final url = Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Lab/UpdateLab/EditLabData');
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          'name': newName,
          'labDescript': newabout,
          'streetAddress': newstreet,
          'area': newarea,
        }),
      );

      if (response.statusCode == 200) {
        print(response.body);
        // Data updated successfully
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Success'),
            content: Text('Data updated successfully.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Failed to update data
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Error'),
            content: Text('Failed to update data.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    } catch (error) {
      // An error occurred
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('An error occurred: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: Text("Update Your Profile"),
        centerTitle: true,
      ),
      body: FutureBuilder<labprofile>(
        future: _labProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            nameController.text = snapshot.data!.name;
            aboutLabController.text = snapshot.data!.labdescription;
            streettController.text = snapshot.data!.street;
            selectedArea = snapshot.data!.area;

            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: [
                  SizedBox(
                    height: 30,
                  ),
                  Stack(
                    children: [
                      Center(
                        child: CircleAvatar(
                          radius: 55,
                          backgroundImage: snapshot.data!.photo != null
                              ? MemoryImage(snapshot.data!.photo!)
                              : null,
                        ),
                      ),
                      Positioned.fill(
                        child: GestureDetector(
                          onTap: pickImage,
                          child: const Icon(Icons.camera_alt_outlined),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: nameController,
                        decoration: InputDecoration(
                          labelText: 'Full Name',
                          contentPadding: EdgeInsets.all(20.0),
                          icon: Icon(Icons.person),
                          hintStyle: TextStyle(fontSize: 15),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       fullName = value;
                        //       });
                        //    },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: aboutLabController,
                        maxLines: null,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          labelText: "About me",
                          icon: Icon(Icons.info_outline_rounded),
                          hintStyle: TextStyle(fontSize: 15),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        //   onChanged: (value) {
                        //    aboutLab = value;
                        //    },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: TextFormField(
                        controller: streettController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          labelText: "Street",
                          icon: Icon(Icons.home_rounded),
                          hintStyle: TextStyle(fontSize: 15),
                          fillColor: Colors.transparent,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide: BorderSide(),
                          ),
                        ),
                        //   onChanged: (value) {
                        //     setState(() {
                        //       street = value;
                        //      });
                        //     },
                      ))
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Colors.black54,
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            width: 100,
                            height: 50,
                            alignment: Alignment.centerLeft,
                            decoration: BoxDecoration(
                              border: Border.all(
                                width: 1,
                                color: Colors.black38,
                              ),
                              borderRadius: BorderRadius.circular(25.0),
                            ),
                            child: Text(
                              "  Area : ",
                              style: TextStyle(color: Colors.black54),
                            ),
                          ),
                          SizedBox(width: 10),
                          StatefulBuilder(
                            builder:
                                (BuildContext context, StateSetter setState) {
                              return DropdownButton<String>(
                                value: selectedArea,
                                onChanged: (item) {
                                  setState(() {
                                    selectedArea = item!;
                                    print(
                                        selectedArea); // Add this line to check the value
                                  });
                                },
                                items: cities.map((item) {
                                  return DropdownMenuItem<String>(
                                    value: item,
                                    child: Text(item,
                                        style: TextStyle(fontSize: 15)),
                                  );
                                }).toList(),
                                borderRadius: BorderRadius.circular(10),
                              );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Divider(),
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10.0),
                    width: double.infinity,
                    child: MaterialButton(
                      onPressed: () async {
                        await updateData(
                          context,
                        );
                        await ApiLab.uploadImage(_image, context);
                        await Navigator.of(context)
                            .push(MaterialPageRoute(builder: (context) {
                          return lab_profile_for_updates();
                        }));
                      },
                      padding: EdgeInsets.all(5.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      color: defaultColor,
                      child: Text(
                        'Submit',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1.5,
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ]),
              ),
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
