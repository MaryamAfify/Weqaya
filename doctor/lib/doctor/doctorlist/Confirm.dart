import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../api_doctor/api.dart';
import '../api_doctor/doctor2.dart';
import '../api_doctor/patient (1).dart';

class confirm extends StatefulWidget {
  const confirm(this.id, this.bookedDate, {super.key});
  final int id;
  final DateTime bookedDate;

  @override
  State<confirm> createState() => _confirmState();
}

class _confirmState extends State<confirm> {
  String? FullName;
  String? phoneNum;
  late String formattedDateTime;

@override
void initState() {
  super.initState();
  formattedDateTime = DateFormat('EEE, d MMMM y h:mm a').format(widget.bookedDate);
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        centerTitle: true,
        title: Text("Confirmation"),
      ),
      body: SafeArea(
          child: Container(
        color: Colors.grey.shade100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(
                height: 30,
              ),
              FutureBuilder<Doctor2?>(
                  future: Api.getDoctorProfileByID(widget.id),
                  builder: ((context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final doctor = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70),
                          // padding: EdgeInsets.all(8),

                          child: Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: snapshot.data!.photo != null
                                      ? MemoryImage(snapshot.data!.photo!)
                                      : null,
                                      radius: 40,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text("Doctor",
                                        style: TextStyle(
                                            fontSize: 10,
                                            fontWeight: FontWeight.bold)),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      doctor!.name,
                                      style: TextStyle(
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(doctor.speciality),
                                SizedBox(height: 20,)
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  })),
              FutureBuilder<Tuple2<Patient, Doctor2?>>(
                  future: Future.wait([
                    Api.getPatientData(),
                    Api.getDoctorProfileByID(widget.id)
                  ]).then((results) =>
                      Tuple2(results[0] as Patient, results[1] as Doctor2?)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final patient = snapshot.data!.item1;
                      final doctor = snapshot.data!.item2;

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      patient.name,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.phone),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      patient.phonenumber,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.calendar_month),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      formattedDateTime,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_rounded),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      doctor!.area,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  }),
              FutureBuilder(
                  future: Api.getDoctorProfileByID(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final doctor = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(children: [
                              Icon(Icons.attach_money),
                              SizedBox(
                                width: 10,
                              ),
                              Text(
                                "Fees",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Text(
                                "${doctor!.price}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ]),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  }),
              Spacer(),
              Row(
                children: [
                  Expanded(
                      child: MaterialButton(
                    onPressed: () {
                      Api.PostBookedDate(widget.bookedDate, widget.id,context);
                    },
                        padding: EdgeInsets.all(5.0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        color: defaultColor,
                        child: Text(
                          'Confirm',
                          style: TextStyle(
                            color: Colors.white,
                            letterSpacing: 1.5,
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  )),
                ],
              ),
            ],
          ),
        ),
      )),
    );
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}
