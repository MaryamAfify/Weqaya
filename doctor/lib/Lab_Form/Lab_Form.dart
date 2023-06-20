import 'dart:io';
import 'package:doctor/Lab_Form/api_for_form_lab/api_lab_form.dart';
import 'package:doctor/Lab_Form/list_lab_inform/list_lab_inform.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' show DateFormat;
class Lab_Form extends StatefulWidget {
  Lab_Form({Key? key});

  @override
  State<Lab_Form> createState() => _Lab_FormState();
}

class _Lab_FormState extends State<Lab_Form> {
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
  ];
  String? selectedArea ;
  List<DateTime> selectedDates = [];
  File? _image;
  final picker = ImagePicker();
  int to = 10;
  int from = 14;
  int duration = 30;
  final _formKey = GlobalKey<FormState>();
  String? fullName;
  String? street;
  String? aboutDoc;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: Text("Complete Your Profile"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 30,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Stack(

                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundColor: Colors.grey,
                          backgroundImage: _image == null ? null : FileImage(_image!),
                        ),
                        Positioned.fill(
                          child: GestureDetector(
                            onTap: pickImage,
                            child: const Icon(Icons.camera_alt_outlined),
                          ),
                        ),
                      ],
                    ),
                    if (_image == null)
                      Text(
                        'Please upload an image',
                        style: TextStyle(color: Colors.red),
                      ),
                  ],
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    labelText: "Full Name",
                    hintText: "ex: Maryam Afify",
                    icon: Icon(Icons.person),
                    hintStyle: TextStyle(fontSize: 15),
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Full Name is required.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      fullName = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  maxLines: null,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    labelText: "About me",
                    icon: Icon(Icons.info_outline_rounded),
                    hintText: "Briefly describe your experience",
                    hintStyle: TextStyle(fontSize: 15),
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'About me is required.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      aboutDoc = value;
                    });
                  },
                ),
                SizedBox(height: 30),
                TextFormField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20.0),
                    labelText: "Street",
                    icon: Icon(Icons.home_rounded),
                    hintText: "27 Mossadak Street",
                    hintStyle: TextStyle(fontSize: 15),
                    fillColor: Colors.transparent,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25.0),
                      borderSide: BorderSide(),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Street is required.';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      street = value;
                    });
                  },
                ),
                SizedBox(height: 30),
              Column(
                children: [
                  Container(

                    child: Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.black54,),
                        SizedBox(width: 20,),
                        Container(
                          width: 100,
                          height: 50,
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                            border: Border.all(width: 1, color: Colors.black38,),
                            borderRadius:  BorderRadius.circular(25.0),
                          ),
                          child: Text(
                            "  Area : ",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            value: selectedArea,
                            items: cities
                                .map((item) => DropdownMenuItem(
                              value: item,
                              child: Text(item, style: TextStyle(fontSize: 15)),
                            ))
                                .toList(),
                            onChanged: (item) => setState(() {
                              selectedArea = item!;
                            }),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please select an area';
                              }
                              return null;
                            },

                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
                SizedBox(height: 50),
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10.0),
                  width: double.infinity,
                  child: MaterialButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await ApiLab.addDoctor(
                          fullName!,
                          selectedArea!,
                          street!,
                          aboutDoc!,
                          context,
                        );
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                          return list_tests_inform();
                        }));
                        await ApiLab.uploadImage(_image, context);
                      }
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
