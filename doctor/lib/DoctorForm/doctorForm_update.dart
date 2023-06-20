import 'dart:convert';
import 'dart:io';
import 'package:doctor/doctor/doctor_profile/doctor_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:http/http.dart' as http;
import '../doctor/api_doctor/api.dart';
import '../doctor/api_doctor/doctor.dart';
import '../styles/colors.dart';

class doctorForm_update extends StatefulWidget {
  doctorForm_update({Key? key});

  @override
  State<doctorForm_update> createState() => _doctorForm_updateState();
}

class _doctorForm_updateState extends State<doctorForm_update> {
  List<String> cities = [
    'Giza',
    'Haram',
    'Faisal',
    'Dokki',
    'Mohandsen',
    '6 of October',
    'Nasr City',
    'Agouza',
    'New Cairo',
    'Abbasya',
    'Ghamra',
    'Ramses',
    'Down Town',
    'Kasr al Ainy',
    '10th of Ramadan'
  ];
  List<String> specialities = [
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
  TextEditingController nameController = TextEditingController();
  TextEditingController aboutDoctorController = TextEditingController();
  TextEditingController streettController = TextEditingController();
  TextEditingController educationController = TextEditingController();
  TextEditingController subSpecialityController = TextEditingController();
  String? selectedArea;
  String? selectedSpec;
  List<DateTime> selectedDates = [];
  File? _image;
  final picker = ImagePicker();
  num? to = 15;
  num? from = 15;
  num? duration = 25;
  num? fees;

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
    String newStreet = streettController.text;
    String newAbout = aboutDoctorController.text;
    String newEduc = educationController.text;
    String newSubSpec = subSpecialityController.text;
    String newArea = selectedArea.toString();
    String newSpec = selectedSpec.toString();
    int newTo = to != null ? to!.toInt() : 1;
    int newFrom = from != null ? from!.toInt() : 1;
    int newDuration = duration != null ? duration!.toInt() : 1;
    int newFees = fees != null ? fees!.toInt() : 0;

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      final url = Uri.parse(
          'http://hadyahmed-001-site1.ctempurl.com/api/Doctor/EditData/EditDoctor');
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "name": newName,
          "speciality": newSpec,
          "education": newEduc,
          "price": newFees,
          "doctorInfo": newAbout,
          "subSpeciatlity": newSubSpec,
          "timeFrom": newFrom,
          "timeTo": newTo,
          "duration": newDuration,
          "area": newArea,
          "streetAddress": newStreet
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
        centerTitle: true,
        title: Text("Update Your Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            FutureBuilder<Doctor>(
              future: Api.getDoctorProfile(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (snapshot.hasData) {
                  nameController.text = snapshot.data!.name;
                  aboutDoctorController.text = snapshot.data!.doctorInfo;
                  streettController.text = snapshot.data!.streetAddress;
                  subSpecialityController.text = snapshot.data!.subSpeciality;
                  educationController.text = snapshot.data!.education;
                  fees = snapshot.data!.price;
                  selectedArea = snapshot.data!.area;
                  selectedSpec = snapshot.data!.speciality;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: CircleAvatar(
                                radius: 55,
                                backgroundImage: _image != null
                                    ? FileImage(_image!)
                                    : (snapshot.data?.photo != null
                                        ? MemoryImage(
                                            snapshot.data!.photo! as Uint8List)
                                        : null) as ImageProvider<Object>?,
                              ),
                            ),
                            GestureDetector(
                              onTap: pickImage,
                              child: const Icon(Icons.camera_alt_outlined),
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
                                contentPadding: EdgeInsets.all(20.0),
                                labelText: "Full Name",
                                icon: Icon(Icons.person),
                                hintStyle: TextStyle(fontSize: 15),
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              //  onChanged: (value) {
                              //  setState(() {
                              //    nameController = value as TextEditingController;
                              //   });
                              //   },
                            ))
                          ],
                        ),
                        SizedBox(height: 30),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                Text("Area:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return DropdownButton<String>(
                                      value: selectedArea,
                                      onChanged: (item) {
                                        setState(() {
                                          selectedArea = item!;
                                          print(selectedArea);
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
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Text("Speciality:",
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold)),
                                StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return DropdownButton<String>(
                                      value: selectedSpec,
                                      onChanged: (item) {
                                        setState(() {
                                          selectedSpec = item!;
                                          print(selectedSpec);
                                        });
                                      },
                                      items: specialities.map((item) {
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
                        SizedBox(
                          height: 25,
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
                              //    setState(() {
                              //      street = value;
                              //    });
                              //   },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: educationController,
                              maxLines: null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20.0),
                                labelText: "Education",
                                icon: Icon(Icons.school),
                                hintText:
                                    "Graduated from faculty of medicine helwan uni",
                                hintStyle: TextStyle(fontSize: 15),
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              //   onChanged: (value) {
                              //      education = value;
                              //     },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: subSpecialityController,
                              maxLines: null,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20.0),
                                icon: Icon(Icons.medical_services_outlined),
                                labelText: "Subspeciality",
                                hintText:
                                    "ex:Consultant of Dermatology and Laser",
                                hintStyle: TextStyle(fontSize: 15),
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              //  onChanged: (value) {
                              //   subSpeciality = value;
                              //  },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              initialValue: fees?.toString(),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20.0),
                                icon: Icon(Icons.attach_money_rounded),
                                labelText: "Fees",
                                hintStyle: TextStyle(fontSize: 15),
                                fillColor: Colors.transparent,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                  borderSide: BorderSide(),
                                ),
                              ),
                              onChanged: (value) {
                                fees = int.parse(value);
                              },
                            ))
                          ],
                        ),
                        SizedBox(
                          height: 35,
                        ),
                        Row(
                          children: [
                            Expanded(
                                child: TextFormField(
                              controller: aboutDoctorController,
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
                              //   onChanged: (value) {
                              //     aboutDoc = value;
                              //    },
                            ))
                          ],
                        ),
                        Divider(),
                        SizedBox(
                          height: 10,
                        ),
                      ]),
                    ),
                  );
                } else {
                  return Center(child: Text('No data available'));
                }
              },
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
                onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
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
                      value: from != null ? from!.toInt() : 1,
                      minValue: 1,
                      maxValue: 25,
                      onChanged: (value) =>
                          setState(() => from = value.toDouble()),
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
                      value: to != null ? to!.toInt() : 1,
                      minValue: 1,
                      maxValue: 25,
                      onChanged: (value) =>
                          setState(() => to = value.toDouble()),
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
                    value: duration != null ? duration!.toInt() : 1,
                    axis: Axis.horizontal,
                    minValue: 10,
                    maxValue: 60,
                    step: 5,
                    onChanged: (value) =>
                        setState(() => duration = value.toDouble()),
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
                  //  Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return DateListScreen();
                  //       }));

                  await updateData(context);
                  await Api.postDates(selectedDates, context);
                  await Api.uploadImage(_image, context);
                  await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                    return doctor_profile();
                  }));

                  print(selectedDates);
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
          ],
        ),
      ),
    );
  }
}
