import 'package:doctor/DoctorView/prescription.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../Animationss/animationLogo.dart';
import '../doctor/api_doctor/api.dart';
import '../doctor/api_doctor/patient2 (2).dart';
class pending extends StatefulWidget {
  const pending({Key? key}) : super(key: key);

  @override
  State<pending> createState() => _pendingState();
}

class _pendingState extends State<pending> {
  List patients = [
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Shams Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Ahmed Khaled"},
    {"name": "Shams Khaled"},
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        appBar: AppBar(
          backgroundColor: defaultColor,
          centerTitle: true,
          title: Text("My Patients"),
        ),
        body: FutureBuilder<List<Patient2>>(
          future: Api.fetchPatientList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child:LogoAnimation(),);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final patient = snapshot.data;

              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: patient!.length,
                          itemBuilder: (context, i) {
                            final formattedDateTime =
                                DateFormat('EEE, d MMMM y h:mm a')
                                    .format(patient[i].patientAppoinment);
                            print(formattedDateTime);
                            return Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              decoration: BoxDecoration(
                                border:
                                    Border.all(width: 1, color: Colors.black12),
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                        backgroundColor: Colors.white,
                                        backgroundImage: NetworkImage(
                                            'https://cdn-icons-png.flaticon.com/512/8247/8247509.png')),
                                    title: Text(
                                      patient[i].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: RichText(
                                      text: TextSpan(
                                        text: patient[i].statusNum == 0
                                            ? 'Pending'
                                            : 'Completed',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: patient[i].statusNum == 0
                                              ? Colors.red
                                              : Colors.blue,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      "Age:${patient[i].age}" as String,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.calendar_month),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(formattedDateTime),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.phone),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(patient[i].phonenumber),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 30,
                                          child: MaterialButton(
                                            padding: EdgeInsets.all(5.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            color: defaultColor,
                                            child: Text("Confirm"),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return prescrip(patient[i].id);
                                              }));
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Container(
                                          width: 120,
                                          height: 30,
                                          child: MaterialButton(
                                            padding: EdgeInsets.all(5.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            color: Colors.red,
                                            child: Text("Cancel"),
                                            onPressed: () {
                                              Api.deleteBoookedPatient(
                                                  patient[i].id, context);
                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ));
  }
}
