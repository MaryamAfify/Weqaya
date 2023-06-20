import 'dart:io';
import 'package:doctor/DoctorView/myProfile.dart';
import 'package:doctor/doctor/doctorlist/docProfile.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../doctor/api_doctor/api.dart';

class doctorForm extends StatefulWidget {
  doctorForm({super.key});

  @override
  State<doctorForm> createState() => _doctorFormState();
}

class _doctorFormState extends State<doctorForm> {
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
  List<String> speciality = [
    "Dermatology",
    "Dentistry",
    "Neurology",
    "Pediatrics and New Borns",
    "Cardiology and Vascular",
    "Psychiatry",
    "Ear,Nose and Throat",
    "Internal Medicine",
    "Orthopedics",
    "Gynaecology and Infertility",
    "Allergy and Immunology",
    "Diabetes and Endocrinology",
    "Nutrition",
    "Chest and Respiratory",
    "Familiy Medicine",
    "Nephrology",
    "Opthalmology",
    "Urology",
    "Hematology",
    "Hepatology",
  ];

  String selectedArea = 'Giza';
  String selectedSpec = 'Dermatology';
  List<DateTime> selectedDates = [];
  // final ImagePicker picker = ImagePicker();
  // File? pickedImage;
  File? _image;
  final picker = ImagePicker();
  int to = 10;
  int from = 14;
  int duration = 30;
  String? fullName;
  String? street;
  String? education;
  String? subSpeciality;
  int? fees;
  String? aboutDoc;
  final _formKey = GlobalKey<FormState>();
  // fetchImages() async {
  //   try {
  //     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
  //     if (image == null) {
  //       return;
  //     }
  //     setState(() {
  //       pickedImage = File(image.path);
  //     });
  //   } on PlatformException catch (e) {
  //     print(e);
  //     Navigator.of(context).pop();
  //   }
  // }
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
        centerTitle: true,
        backgroundColor: defaultColor,
        title: Text("Complete Your Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            _image == null ? null : FileImage(_image!),
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
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      labelText: "Full Name",
                      hintText: "ex:Maryam Afify",
                      
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
                        return 'Full Name me is required.';
                      }
                     if (!RegExp(r'^[a-zA-Z ]+$').hasMatch(value)) {
        return 'Only characters and spaces are allowed.';
      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        fullName = value;
                      });
                    },
                  ))
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Text("Area:", style: TextStyle(fontWeight: FontWeight.bold)),
                  DropdownButton<String>(
                    value: selectedArea,
                    items: cities
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item, style: TextStyle(fontSize: 15))))
                        .toList(),
                    onChanged: (item) => setState(() {
                      selectedArea = item!;
                    }),
                    //icon: Icon(Icons.location_on_outlined),

                    borderRadius: BorderRadius.circular(10),
                  ),
                ],
              ),
              SizedBox(
                height: 25,
              ),
              Column(
                children: [
                  Text(
                    "Speciality:",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  DropdownButton<String>(
                    value: selectedSpec,
                    items: speciality
                        .map((item) => DropdownMenuItem(
                            value: item,
                            child: Text(item, style: TextStyle(fontSize: 15))))
                        .toList(),
                    onChanged: (item) => setState(() {
                      selectedSpec = item!;
                    }),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
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
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      labelText: "Education",
                      icon: Icon(Icons.school),
                      hintText: "Graduated from faculty of medicine helwan uni",
                      hintStyle: TextStyle(fontSize: 15),
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Education is required.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      education = value;
                    },
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      icon: Icon(Icons.medical_services_outlined),
                      labelText: "Subspeciality",
                      hintText: "ex:Consultant of Dermatology and Laser",
                      hintStyle: TextStyle(fontSize: 15),
                      fillColor: Colors.transparent,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide(),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'SubSpecialty is required.';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      subSpeciality = value;
                    },
                  ))
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(20.0),
                        icon: Icon(Icons.attach_money_rounded),
                        labelText: "Fees",
                        hintText: "300",
                        hintStyle: TextStyle(fontSize: 15),
                        fillColor: Colors.transparent,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(),
                        ),
                      ),
                      keyboardType: TextInputType
                          .number, // Set the keyboard type to number
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Fees is required.';
                        }
                        if (int.tryParse(value) == null) {
                          return 'Please enter a valid number.';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        fees = int.tryParse(value) ??
                            0; // Update fees variable with parsed value or 0 if parsing fails
                      },
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
                    maxLines: null,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(20.0),
                      labelText: "About me",
                      icon: Icon(Icons.info_outline_rounded),
                      hintText: "brief about your experience",
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
                      aboutDoc = value;
                    },
                  ))
                ],
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Text(
                "Clinic Appoinments",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.grey.shade100,
                ),
                padding: EdgeInsets.all(8),
                child: SfDateRangePicker(
                  // view: DateRangePickerView.month,
                  selectionMode: DateRangePickerSelectionMode.multiple,
                  // showActionButtons: true,
                  onSelectionChanged:
                      (DateRangePickerSelectionChangedArgs args) {
                    setState(() {
                      selectedDates = List<DateTime>.from(args.value);
                    });
                    print(selectedDates);
                    //testing
                  },
                  // onSubmit: (value) {
                  //   print("hi");
                  // }, // send dates to api
                  // cancelText: 'CANCEL DATES',
                  // confirmText: 'ADD DATES',
                  showNavigationArrow: true,
                ),
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text("From",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      NumberPicker(
                        value: from,
                        minValue: 1,
                        maxValue: 25,
                        onChanged: (value) => setState(() => from = value),
                      ),
                      Text('Current Hour: $from'),
                      // Container(
                      //   width: 130.0, // Set the desired width
                      //   height: 40.0, // Set the desired height

                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: 'Ex:from 10',
                      //       hintStyle: TextStyle(
                      //         fontSize: 15,
                      //       ),
                      //       contentPadding: EdgeInsets.all(20.0),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(25.0),
                      //         borderSide: BorderSide(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  Column(
                    children: [
                      Text("To",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 15)),
                      SizedBox(
                        height: 10,
                      ),
                      NumberPicker(
                        value: to,
                        minValue: 1,
                        maxValue: 25,
                        onChanged: (value) => setState(() => to = value),
                      ),
                      Text('Current Hour: $to'),
                      // Container(
                      //   width: 130.0,
                      //   height: 40.0,
                      //   child: TextField(
                      //     decoration: InputDecoration(
                      //       hintText: 'Ex:to 16',
                      //       hintStyle: TextStyle(
                      //         fontSize: 15,
                      //       ),
                      //       contentPadding: EdgeInsets.all(20.0),
                      //       border: OutlineInputBorder(
                      //         borderRadius: BorderRadius.circular(25.0),
                      //         borderSide: BorderSide(),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Duration(min):",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  SizedBox(width: 35),
                  Expanded(
                    child: NumberPicker(
                      value: duration,
                      axis: Axis.horizontal,
                      minValue: 10,
                      maxValue: 60,
                      step: 5,
                      onChanged: (value) => setState(() => duration = value),
                    ),
                  ),
                  // Container(
                  //   width: 90.0,
                  //   height: 40.0,
                  //   child: TextField(
                  //     decoration: InputDecoration(
                  //       hintText: '30 min',
                  //       hintStyle: TextStyle(
                  //         fontSize: 15,
                  //       ),
                  //       contentPadding: EdgeInsets.all(20.0),
                  //       border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(25.0),
                  //         borderSide: BorderSide(),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
              Divider(),
              SizedBox(
                height: 25,
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await Api.addDoctor(
                        fullName!,
                        selectedArea,
                        selectedSpec,
                        street!,
                        education!,
                        subSpeciality!,
                        fees!,
                        aboutDoc!,
                        from,
                        to,
                        duration,
                      );
                      await Api.postDates(selectedDates, context);
                      await Api.uploadImage(_image, context);

                         Navigator.push(context, MaterialPageRoute(builder: (context) {
          return myProfile();
        }));

                      print(selectedDates);
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
              )
            ]),
          ),
        ),
      ),
    );
  }
}
