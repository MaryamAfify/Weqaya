import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../styles/colors.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'get_patient_data/get_api.dart';
class personal_information extends StatefulWidget {
  const personal_information({Key? key}) : super(key: key);

  @override
  State<personal_information> createState() => _personal_informationState();
}

class _personal_informationState extends State<personal_information> {

  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController heightController = TextEditingController();
  TextEditingController weightController = TextEditingController();
  String? selectedValuediabetes ;
  String? selectedValuerelativesdiabetes ;
  String? selectedValuepressure ;
  String? selectedValuediabetesandpressure ;
  String? selectedValuesmoking ;
  String? selectedValuemedicine ;
  late Future<Album> futureAlbum;
  List<String> boolean =[
    'true',
    'false'
  ];

  @override
  void initState() {
    super.initState();
    futureAlbum = api.getPost();
  }
  Future<void> updateData(BuildContext context) async {
    String newName = nameController.text;
    String newPhoneNumber = phoneNumberController.text;
    String newAge = ageController.text;
    String newHeight = heightController.text;
    String newWeight = weightController.text;
    String newdiabetes = selectedValuediabetes.toString();
    String newdiabetesrelatives = selectedValuerelativesdiabetes.toString();
    String newpressure = selectedValuepressure.toString();
    String newmedicine = selectedValuemedicine.toString();
    String newdiabetesandpressure = selectedValuediabetesandpressure.toString();
    String newsmoking = selectedValuesmoking.toString();

    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String? token = pref.getString('token');
      final url = Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Patient/EditPatient/EditPatientData');
      final response = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json;charset=utf-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(<String, dynamic>{
          "name": newName,
          "age": newAge,
          "weight": newWeight,
          "height": newHeight,
          "phoneNumber": newPhoneNumber,
          "diabetesRelatives": newdiabetesrelatives,
          "relativesWithHeartAttacksOrHighColestrol": newdiabetesandpressure,
          "smoking": newsmoking,
          "medicineForDiabetesOrPressure": newmedicine,
          "highPressure": newpressure,
          "diabetes": newdiabetes,
          "doctorPatients":[],
          "labPatients":[],
          "patientTestsAndRisks":[],
          "patientTestsOrRisksOcr":[],
          "doctorReviews":[],
          "labReviews":[],
        }),
      );


      if (response.statusCode == 200) {
        print(response.body);
        // Data updated successfully
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Data updated successfully"),
            duration: Duration(seconds: 2), // Duration for which the toast should be visible
          ),
        );
      } else {
        // Failed to update data
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Failed to update data. HTTP Status Code: ${response.statusCode}"),
            duration: Duration(seconds: 2), // Duration for which the toast should be visible
          ),
        );
      }
    } catch (error) {
      // An error occurred
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("An error occurred: $error"),
          duration: Duration(seconds: 2), // Duration for which the toast should be visible
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text("Update Personal Information"),
      backgroundColor: defaultColor),
      body: SafeArea(
        child: FutureBuilder<Album>(
          future: futureAlbum,
          builder: (context, snapshot) {
          if  (snapshot.connectionState == ConnectionState.waiting) {
    // While waiting for the data to load, show a loading indicator
    return Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
    // If an error occurred while fetching the data, display an error message
    return  Text(snapshot.error.toString());}
            if (snapshot.hasData) {
              nameController.text = snapshot.data!.name;
              phoneNumberController.text = snapshot.data!.phoneNumber;
              ageController.text = snapshot.data!.age.toString();
              heightController.text = snapshot.data!.height.toString();
              weightController.text = snapshot.data!.weight.toString();
              selectedValuediabetes = snapshot.data!.diabetes.toString();
              selectedValuepressure = snapshot.data!.highPressure.toString();
              selectedValuediabetesandpressure = snapshot.data!.relativesWithHeartAttacksOrHighCholesterol.toString();
              selectedValuerelativesdiabetes = snapshot.data!.diabetesRelatives.toString();
              selectedValuemedicine = snapshot.data!.medicineForDiabetesOrPressure.toString();
              selectedValuesmoking = snapshot.data!.smoking.toString();
            }
            return Center(
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
                width: 350,
                height: 700,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Full Name")),
                          Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child :TextFormField(
                              autofocus: false,
                              controller: nameController, // <-- SEE HERE
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12,width:5),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  )
                              ),
                            //  onChanged: (newname){
                            //    newname=snapshot.data!.name;
                           //   },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Phone Number")),
                          Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child :TextFormField(
                              autofocus: false,
                           //   initialValue: snapshot.data!.phonenumber,
                              controller: phoneNumberController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12,width:5),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  )
                              ),
                            //  onChanged: (newphonenumber){
                            //    newphonenumber=snapshot.data!.phonenumber;
                            //  },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Age")),
                          Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child :TextFormField(
                              autofocus: false,
                           //   initialValue: snapshot.data!.age.toString(), // <-- SEE HERE
                             controller: ageController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12,width:5),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  )
                              ),
                            //  onChanged: (newage){
                              //  newage=snapshot.data!.age.toString();
                            //  },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Height")),
                          Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child :TextFormField(
                              autofocus: false,
                            //  initialValue: snapshot.data!.height.toString(), // <-- SEE HERE
                             controller: heightController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12,width:5),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  )
                              ),
                            //  onChanged: (newheight){
                            //    newheight=snapshot.data!.height.toString();
                           //   },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10,),
                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Weight")),
                          Container(
                            color: Colors.white,
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            child :TextFormField(
                              autofocus: false,
                             // initialValue: snapshot.data!.weight.toString(), // <-- SEE HERE
                             controller: weightController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                  border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black12,width:5),
                                      borderRadius: BorderRadius.all(Radius.circular(10))
                                  )
                              ),
                             // onChanged: (newweight){
                             //   newweight = snapshot.data!.weight.toString();
                             // },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),

                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Diabetes :",)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: double.infinity, // Set the width to match the TextFormField
                            height: 50, // Set the desired height of the dropdown
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return DropdownButton(
                                  value: selectedValuediabetes,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text(" Yes"),
                                      value: "true",
                                    ),
                                    DropdownMenuItem(
                                      child: Text(" NO"),
                                      value: "false",
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValuediabetes = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),

                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Relatives With Diabetes :",)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: double.infinity, // Set the width to match the TextFormField
                            height: 50, // Set the desired height of the dropdown
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return DropdownButton(
                                  value: selectedValuerelativesdiabetes,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Yes"),
                                      value: "true",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("NO"),
                                      value: "false",
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValuerelativesdiabetes = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),

                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("High Pressure:",)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: double.infinity, // Set the width to match the TextFormField
                            height: 50, // Set the desired height of the dropdown
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return DropdownButton(
                                  value: selectedValuepressure,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Yes"),
                                      value: "true",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("NO"),
                                      value: "false",
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValuepressure = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ), SizedBox(height: 25,),

                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Relatives With Heart Attacks Or High Colestrol:",)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: double.infinity, // Set the width to match the TextFormField
                            height: 50, // Set the desired height of the dropdown
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return DropdownButton(
                                  value: selectedValuediabetesandpressure,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Yes"),
                                      value: "true",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("NO"),
                                      value: "false",
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValuediabetesandpressure = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),

                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Medicine For Diabetes Or Pressure:",)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: double.infinity, // Set the width to match the TextFormField
                            height: 50, // Set the desired height of the dropdown
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return DropdownButton(
                                  value: selectedValuemedicine,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Yes"),
                                      value: "true",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("NO"),
                                      value: "false",
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValuemedicine = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 25,),

                      Column(
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(10, 10, 0, 0),
                              alignment: Alignment.centerLeft,
                              child: Text("Smoking:",)),
                          Container(
                            alignment: Alignment.centerLeft,
                            margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                            width: double.infinity, // Set the width to match the TextFormField
                            height: 50, // Set the desired height of the dropdown
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black38, width: 1),
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            child: StatefulBuilder(
                              builder: (BuildContext context, StateSetter setState) {
                                return DropdownButton(
                                  value: selectedValuesmoking,
                                  items: [
                                    DropdownMenuItem(
                                      child: Text("Yes"),
                                      value: "true",
                                    ),
                                    DropdownMenuItem(
                                      child: Text("NO"),
                                      value: "false",
                                    )
                                  ],
                                  onChanged: (String? value) {
                                    setState(() {
                                      selectedValuesmoking = value!;
                                    });
                                  },
                                );
                              },
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 25,),
                      Container(
                        color: Colors.white,
                        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                        child : SizedBox(

                          width: double.infinity,
                          child: MaterialButton(
                            elevation: 5.0,
                            onPressed: () {
                              updateData(
                                context,
                              );
                             // validateAndSave();
                             // login(email.toString(), password.toString(),context);
                            },
                            //        => print('Login Button Pressed'),
                            padding: EdgeInsets.all(5.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            color: defaultColor,
                            child: Text(
                              'Update',
                              style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 1.5,
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            );

            return const CircularProgressIndicator();
          }
          ),
      ),
    );
  }
}
