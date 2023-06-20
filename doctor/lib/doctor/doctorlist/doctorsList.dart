import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../Animationss/animationLogo.dart';
import '../api_doctor/api.dart';
import '../api_doctor/doctor4.dart';
import 'docProfile.dart';

class doctorList extends StatefulWidget {
  const doctorList(this.area, this.speciality, {super.key});
  final String area;
  final String speciality;

  @override
  State<doctorList> createState() => _doctorListState();
}

class _doctorListState extends State<doctorList> {
  // List doctors = [
  //   {"name": "Maryam Afify", "spec": "Dermataolgy"},
  //   {"name": "Ahmed Afify", "spec": "Dermataolgy"},
  //   {"name": "Sara Ahmed", "spec": "Dermataolgy"},
  //   {"name": "Khaled Mohamed", "spec": "Dermataolgy"},
  //   {"name": "Youssef Ahmed", "spec": "Dentist"},
  //   {"name": "Ahmed Afify", "spec": "Dermataolgy"},
  //   {"name": "Maryam Afify", "spec": "Dentist"},
  //   {"name": "Ahmed Afify", "spec": "Dermataolgy"},
  // ];
  List foundDoctors = [];
  @override
  // void initState() {
  //   foundDoctors = doctors;
  //   super.initState();
  // }

  // void _runFilter(String enteredKeyword) {
  //   List result = [];
  //   if (enteredKeyword.isEmpty) {
  //     result = doctors;
  //   } else {
  //     result = doctors
  //         .where((user) =>
  //             user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();
  //     result = doctors
  //         .where((user) =>
  //             user["spec"].toLowerCase().contains(enteredKeyword.toLowerCase()))
  //         .toList();

  //     we use the lower case method to make it case insensitive
  //   }
  // setState(() {
  //   foundDoctors = result;
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: const Text("Select Doctor"),
        centerTitle: true,
      ),
      body: Column(
        // mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: FutureBuilder<List<Doctor4>>(
                future: Api.getDoctors(widget.area, widget.speciality),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return Center(child: Text("No Doctors Available"));
                    }
                    print(widget.area);
                    print(widget.speciality);

                    return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: ((context, i) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                              child: Card(
                                margin: EdgeInsets.symmetric(vertical: 3),
                                elevation: 0,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                color: Colors.white,
                                shadowColor: Colors.grey.shade300,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          // ignore: prefer_const_constructors
                                          CircleAvatar(
                                            backgroundImage: snapshot
                                                        .data![i].photo !=
                                                    null
                                                ? MemoryImage(
                                                    snapshot.data![i].photo!)
                                                : null,
                                            radius: 40,
                                          ),
                                          SizedBox(
                                            width: 20,
                                          ),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    Text("Doctor",
                                                        style: TextStyle(
                                                            fontSize: 10,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                    SizedBox(
                                                      width: 5,
                                                    ),
                                                    Text(
                                                      snapshot.data![i].name,
                                                      style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 16,
                                                      ),
                                                      maxLines: null,
                                                      softWrap: true,
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot.data![i].speciality,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54),
                                                  maxLines: 3,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Text(
                                                  snapshot
                                                      .data![i].subSpeciality,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black54),
                                                  maxLines: null,
                                                  softWrap: true,
                                                  textAlign: TextAlign.center,
                                                ),
                                                SizedBox(
                                                  height: 5,
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      SmoothStarRating(
                                                        rating: snapshot
                                                            .data![i].avg
                                                            .toDouble(),
                                                        // rating: averageRating,
                                                        size: 30,
                                                        filledIconData: Icons
                                                            .star_rate_rounded,

                                                        defaultIconData: Icons
                                                            .star_border_rounded,

                                                        starCount: 5,

                                                        allowHalfRating: false,
                                                        spacing: 3,
                                                        color: Colors.amber,
                                                      ),
                                                    ])
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.location_on_outlined,
                                                size: 20,
                                                color: Colors.cyan,
                                              ),
                                              Text(
                                                snapshot.data![i].area,
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Row(
                                            children: [
                                              Icon(
                                                Icons.attach_money_rounded,
                                                size: 20,
                                                color: Colors.cyan,
                                              ),
                                              Text(
                                                'Fees:${snapshot.data![i].price}',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Container(
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                    color:
                                                        Colors.grey.shade300),
                                                width: 215,
                                                height: 32,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Text(
                                                    "Available everyday from ${snapshot.data![i].timeFrom} to ${snapshot.data![i].timeTo}",
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.black38),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 50,
                                              ),
                                              CircleAvatar(
                                                backgroundColor: defaultColor,
                                                child: IconButton(
                                                  onPressed: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) {
                                                        return docProfile(
                                                            snapshot
                                                                .data![i].id);

                                                        // "${doctors[i]['name']}",
                                                        // "${doctors[i]['spec']}");
                                                      }),
                                                    );
                                                  },
                                                  icon:
                                                      Icon(Icons.arrow_forward),
                                                  color: Colors.white,
                                                  highlightColor: Colors.pink,
                                                  splashColor:
                                                      Colors.blueAccent,
                                                ),
                                              )
                                            ],
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }));
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }

                  return Center(
                    child: LogoAnimation(),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
