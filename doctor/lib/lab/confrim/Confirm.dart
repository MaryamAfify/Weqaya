import 'package:doctor/lab/confrim/api_cofirm/api_confirm.dart';
import 'package:doctor/lab/lab_for_patient/api_for_lab_fromlist_toprofile-byid.dart';
import 'package:doctor/lab/lab_profile_updates/screens/api_for_update/get_lab_profile_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:intl/intl.dart';

import '../../home_screen/screens/profile_screens/get_patient_data/get_api.dart';
import '../../styles/colors.dart';
import '../lab_profile_updates/book_test/book_tests_patient/gettests_byid.dart';

class confirm_lab extends StatefulWidget {
  final int id;
  final int idtest;
  final String name;
  final int price;

  const confirm_lab(
      this.id,
      this.idtest,
      this.name,
  this.price,{
        Key? key,
      }) : super(key: key);

  @override
  State<confirm_lab> createState() => _confirm_labState();
}

class _confirm_labState extends State<confirm_lab> {
  String? fullName;
  String? phoneNum;

  @override
  void initState() {
    super.initState();
    fetchPatientData();
  }

  Future<void> fetchPatientData() async {
    final patientData = await api.getPost();
    setState(() {
      fullName = patientData.name;
      phoneNum = patientData.phoneNumber;
    });
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
                SizedBox(height: 30),
                FutureBuilder<labprofile?>(
                  future: apiprofile.getLabProfileByID(widget.id),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final lab = snapshot.data;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                CircleAvatar(
                                  backgroundImage: snapshot.data!.photo != null
                                      ? MemoryImage(snapshot.data!.photo!)
                                      : null,
                                ),
                                SizedBox(height: 10),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(width: 5),
                                    Text(
                                      lab!.name,
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  },
                ),
                FutureBuilder<Tuple2<Album, labprofile?>>(
                  future: Future.wait([
                    api.getPost(),
                    apiprofile.getLabProfileByID(widget.id),
                  ]).then((results) => Tuple2(
                      results[0] as Album, results[1] as labprofile?)),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    } else if (snapshot.hasData) {
                      final patient = snapshot.data!.item1;
                      final lab = snapshot.data!.item2;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white70,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.person),
                                    SizedBox(width: 10),
                                    Text(
                                      fullName ?? 'N/A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  children: [
                                    Icon(Icons.phone),
                                    SizedBox(width: 10),
                                    Text(
                                      phoneNum ?? 'N/A',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_rounded),
                                    SizedBox(width: 10),
                                    Text(
                                      lab!.area,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),SizedBox(height: 30,),
                                Row(
                                  children: [
                                    Icon(Icons.attach_money),
                                    SizedBox(width: 10),
                                    Text(
                                      "Fees",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      widget.price.toString(),
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30),
                                Row(
                                  children: [
                                    Icon(Icons.local_hospital_outlined),
                                    SizedBox(width: 10),
                                    Text(
                                      "Tests",
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    Spacer(),
                                    Text(
                                      widget.name,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    } else {
                      return Center(child: Text('No data found'));
                    }
                  },
                ),

                Spacer(),
                Row(
                  children: [
                    Expanded(
                      child: MaterialButton(
                        onPressed: () {
                          // Perform confirmation action here
                          apibook.PostBookedTest(widget.id, widget.idtest , widget.price,context);
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}
