import 'package:doctor/styles/colors.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:time_slot/controller/day_part_controller.dart';
import 'package:time_slot/time_slot_from_list.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../Animationss/animationLogo.dart';
import '../api_doctor/api.dart';
import '../api_doctor/doctor.dart';
import '../api_doctor/doctor2.dart';
import '../api_doctor/review.dart';
import 'dateAndhour.dart';

class docProfile extends StatefulWidget {
  const docProfile(this.id, {super.key});
  final int id;

  @override
  State<docProfile> createState() => _docProfileState();
}

class _docProfileState extends State<docProfile> {
  late Future<Doctor> futureDoctor;

  // String About =
  //     'ana doctor gamel w amor shater gedan w gebt A+ fe kol el mwad w 3andy 33 sana w handsome et5argt mn helwan uni year 2009 w nawy isa a5od PHD bs fe gam3a tanya msh helwan 3lshan its very hot';
  DateTime date = DateTime.now();

  List<DateTime> dates = [
    DateTime(
      2023,
      4,
      1,
    ),
    DateTime(
      2023,
      4,
      2,
    ),
    DateTime(
      2023,
      4,
      3,
    ),
    DateTime(
      2023,
      4,
      4,
    ),
    DateTime(
      2023,
      4,
      5,
    ),
    DateTime(
      2023,
      1,
      6,
    )
  ];

  // List reviews = [
  //   {
  //     "name": "Maryam Afify",
  //     "rev": "Good DoctorsknadjkacuiabuaigbcKSJBCOI:CGKjcnckzxkbcuABCSUI"
  //   },
  //   {"name": "Ahmed Afify", "rev": "Good listener"},
  //   {"name": "Sara Ahmed", "rev": "Gamed gedan "},
  //   {"name": "Khaled Mohamed", "rev": "Tohfaaaaaaa!!!"},
  //   {"name": "Youssef Ahmed", "rev": "El clinic ndefa w gamela"},
  //   {"name": "Ahmed Afify", "rev": "rude"},
  //   {"name": "Maryam Afify", "rev": "Not really good"},
  //   {"name": "Ahmed Afify", "rev": "1/10"},
  //   {"name": "Sara Ahmed", "rev": "Gamed gedan "},
  //   {"name": "Khaled Mohamed", "rev": "Tohfaaaaaaa!!!"},
  //   {"name": "Youssef Ahmed", "rev": "El clinic ndefa w gamela"},
  //   {"name": "Ahmed Afify", "rev": "rude"},
  //   {"name": "Maryam Afify", "rev": "Not really good"},
  //   {"name": "Ahmed Afify", "rev": "1/10"},
  //   {"name": "Sara Ahmed", "rev": "Gamed gedan "},
  //   {"name": "Khaled Mohamed", "rev": "Tohfaaaaaaa!!!"},
  //   {"name": "Youssef Ahmed", "rev": "El clinic ndefa w gamela"},
  // ];

  List reviews = [];
  var rating = 4.0;

  DayPartController dayPartController = DayPartController();

  void DatePicker() {
    SfDateRangePicker(
      initialDisplayDate: date,
      showActionButtons: true,
      selectableDayPredicate: (DateTime val) =>
          dates.contains(DateTime(val.year, val.month, val.day)) ? true : false,

      // val.day==4 || val.weekday == 6|| val.weekday == 5 ? true : false,
      showTodayButton: true,
    );
  }

  @override
  // void initState() {
  //   super.initState();
  //   futureDoctor = Api.getDoctorProfileByID(widget.id);
  // }

  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: defaultColor,
          centerTitle: true,
          title: Text("Doctor profile"),
        ),
        body: FutureBuilder<Doctor2?>(
          future: Api.getDoctorProfileByID(widget.id),
          builder: ((context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the data to load, show a loading indicator
              return Center(child:LogoAnimation(),);
            } else if (snapshot.hasError) {
              // If an error occurred while fetching the data, display an error message
              return Center(child: Text('Error loading doctor profile'));
            } else if (snapshot.hasData) {
              // If the data has been successfully fetched, display the doctor profile
              final doctor = snapshot.data!;
              return SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8.0),
                  margin: EdgeInsets.all(2),
                  height: 1000,
                  width: 1000,
                  child: Column(
                    children: [
                      Card(
                          // margin: EdgeInsets.symmetric(vertical: 10),
                          elevation: 3,
                          // shape: RoundedRectangleBorder(
                          //   borderRadius: BorderRadius.circular(10),
                          // ),
                          color: Colors.white,
                          shadowColor: Colors.grey.shade300,
                          child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      // ignore: prefer_const_constructors
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundImage: snapshot.data!.photo !=
                                                null
                                            ? MemoryImage(snapshot.data!.photo!)
                                            : null,
                                      ),
                                      SizedBox(
                                        width: 15,
                                      ),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text("Doctor",
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold)),
                                                SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  doctor.name,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 16),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(doctor.speciality,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black54)),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              doctor.subSpeciality,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black54,
                                              ),
                                              maxLines: null,
                                              softWrap: true,
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ))),
                      Divider(),
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 25,
                                  color: Colors.cyan,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  doctor.area,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  'Book for address details',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money_rounded,
                                  size: 25,
                                  color: Colors.cyan,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  '${doctor.price}',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 4),
                            Row(
                              children: [
                                SizedBox(width: 40),
                                Text(
                                  'Consultation Fees',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      Divider(),
                      Container(
                        child: Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "About Doctor",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ExpandableText(
                                  doctor.doctorInfo,
                                  expandText: 'Show more',
                                  collapseText: 'Show less',
                                  maxLines: 3,
                                  linkColor: Colors.blueAccent,
                                  animation: true,
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          color: Colors.white,
                          shadowColor: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Education",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10),
                                ExpandableText(
                                  doctor.education,
                                  style: TextStyle(
                                    color: Colors.black87,
                                  ),
                                  expandText: 'Show more',
                                  collapseText: 'Show less',
                                  maxLines: 3,
                                  linkColor: Colors.blueAccent,
                                  animation: true,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return dateAndhour(widget.id);
                          }));
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(defaultColor),
                          minimumSize: MaterialStateProperty.all(Size(
                              double.infinity,
                              40)), // Set the width to double.infinity for a wider button
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  30), // Adjust the borderRadius for a more or less rounded button
                            ),
                          ),
                        ),
                        child: Text(
                          "Book Now",
                          style: TextStyle(
                              fontSize: 18), // Adjust the font size as needed
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      // Divider(),
                      Row(
                        children: [
                          Text(
                            "Patient's Reviews",
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          Spacer(),
                          Icon(
                            Icons.star_rounded,
                            color: Colors.amber,
                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Divider(),
                      FutureBuilder<Map<String, dynamic>>(
                        future: Api.fetchReviewsbyID(widget.id),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            List<Review> reviews = snapshot.data!['reviews'];
                            //double averageRating = snapshot.data!['avg'];

                            return Expanded(
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: reviews.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.symmetric(vertical: 4),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.grey.withOpacity(0.2),
                                          blurRadius: 3,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            SmoothStarRating(
                                              rating:
                                                  reviews[i].rating.toDouble(),
                                              size: 20,
                                              filledIconData:
                                                  Icons.star_rate_rounded,
                                              defaultIconData:
                                                  Icons.star_border_rounded,
                                              starCount: 5,
                                              allowHalfRating: false,
                                              spacing: 3,
                                              color: Colors.amber,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          reviews[i].text,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          reviews[i].name,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                            color: Colors.black54,
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return Center(child: Text('No data found'));
                          }
                        },
                      ),

                      Divider(),
                    ],
                  ),
                ),
              );
            } else {
              // If no data is available, display a message
              return Center(child: Text('No data available'));
            }
          }),
        ));
  }
}
