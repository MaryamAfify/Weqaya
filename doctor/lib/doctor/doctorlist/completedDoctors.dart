import 'package:doctor/doctor/doctorlist/reviewDialog.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../Animationss/animationLogo.dart';
import '../api_doctor/api.dart';
import '../api_doctor/doctor3 (1).dart';
import 'docProfile.dart';
class completedDoctors extends StatefulWidget {
  const completedDoctors({Key? key}) : super(key: key);

  @override
  State<completedDoctors> createState() => _completedDoctorsState();
}

class _completedDoctorsState extends State<completedDoctors> {
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
        body: FutureBuilder<List<Doctor3>>(
          future: Api.fetchBookedDoctorsCompleted(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LogoAnimation(),);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final doctor = snapshot.data;

              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: doctor!.length,
                          itemBuilder: (context, i) {
                            final formattedDateTime =
                                DateFormat('EEE, d MMMM y h:mm a')
                                    .format(doctor[i].appoinments);

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
                                      backgroundImage:
                                          snapshot.data![i].photo != null
                                              ? MemoryImage(
                                                  snapshot.data![i].photo!)
                                              : null,
                                    ),
                                    title: Text(
                                      doctor[i].name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: RichText(
                                      text: TextSpan(
                                        text: doctor[i].statusNum == 2
                                            ? 'Cancelled'
                                            : 'Completed',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: doctor[i].statusNum == 2
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ),
                                    ),
                                    subtitle: Text(
                                      doctor[i].speciality,
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
                                            Icon(Icons.location_on_sharp),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(doctor[i].area),
                                          ],
                                        ),
                                        Row(
                                          children: [
                                            Icon(Icons.attach_money_rounded),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text("${doctor[i].price}"),
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
                                            child: Text(
                                              "Doctor Profile",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                return docProfile(doctor[i].id);
                                              }));
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        if (doctor[i].statusNum == 1)
                                          Container(
                                            width: 120,
                                            height: 30,
                                            child: MaterialButton(
                                              padding: EdgeInsets.all(5.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              color: defaultColor,
                                              child: Text(
                                                "Review Doctor",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      ReviewDialog(doctor[i].id),
                                                );
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
