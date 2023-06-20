import 'package:doctor/Animationss/animationLogo.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import 'api_patient_lab/api_patient_lab.dart';
import 'history_lab.dart';
import 'notes.dart';

class myPatients_lab extends StatefulWidget {
  const myPatients_lab({Key? key}) : super(key: key);

  @override
  State<myPatients_lab> createState() => _myPatients_labState();
}

class _myPatients_labState extends State<myPatients_lab> {
  List patients = [
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: FutureBuilder<List<patientslist>>(
          future: apiviewpatients.fetchPatientList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child:LogoAnimation());
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
                                  ),
                                 Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons .phone),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(patient[i].phoneNumber),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                                Icon(Icons.local_hospital_outlined),
                                                SizedBox(
                                                  width: 20,
                                                ),
                                                Text(patient[i].testsOrRisks),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(children: [
                                              Icon(Icons.attach_money_rounded),
                                              SizedBox(width: 20,),
                                              Text(
                                                "Price  :${patient[i].price}" as String,
                                              ),
                                            ],
                                            ),

                                          ],
                                        ),
                                      ],
                                    ),
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
                                            onPressed: ()
                                            {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return notes_lab(patient[i].id);
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
                                              apiviewpatients.deleteBookedDoctor(patient[i].id,context);
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
