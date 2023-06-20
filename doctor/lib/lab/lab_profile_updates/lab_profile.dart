import 'package:doctor/lab/lab_for_patient/api_for_lab_fromlist_toprofile-byid.dart';
import 'package:doctor/lab/lab_profile_updates/book_test/book_tests_patient/get_ui_tests_patient.dart';
import 'package:doctor/lab/lab_profile_updates/screens/api_for_update/api_lab_profile.dart';
import 'package:doctor/lab/lab_profile_updates/screens/api_for_update/get_lab_profile_class.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:doctor/lab/lab_review/api_lab_review/api_lab_review.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';
import '../../Animationss/animationLogo.dart';
import '../lab_review/api_lab_review/review.dart';
import 'book_test/gettests_ui.dart';

class Lab_profile extends StatefulWidget {
  const Lab_profile(this.id, {Key? key}) : super(key: key);
  final int id;

  @override
  State<Lab_profile> createState() => _Lab_profileState();
}

class _Lab_profileState extends State<Lab_profile> {
  late Future<labprofile> _labProfileFuture;
  String availabletests = 'CBC 300 , RFT 300 ,HPP 500, habc 800 ';
  @override

  //Future<void> _fetchLabProfile() async {
  // final api = Apilabprofile();
  // _labProfileFuture = apiprofile.getLabProfileByID(widget.id) as Future<labprofile>;
  //}
  List reviews = [];
  var rating = 0.0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        centerTitle: true,
        title: Text("Lap Profile"),
      ),
      body: FutureBuilder<labprofile?>(
          future: apiprofile.getLabProfileByID(widget.id),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LogoAnimation(),);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final labprofile = snapshot.data!;
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
                          color: Colors.white,
                          shadowColor: Colors.grey.shade300,
                          child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
// ignore: prefer_const_constructors
                                Container(
                                  width: 380,
                                  height: 120,
                                  child:Column(children:[
                                  CircleAvatar(

                                      backgroundImage: snapshot.data!.photo !=
                                              null
                                          ? MemoryImage(snapshot.data!.photo!)
                                          : null,
                                    radius: 45,
                                    ),
                                  Text(' ${labprofile.name}',
                                  style: TextStyle(fontSize: 20,),),
                                ])),
                                ],
                              ))),
                      Divider(),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.fromLTRB(0, 5, 10, 5),
                        child:   Column(
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
                                      labprofile.area,
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
                          ],
                        ),
                      ),
                      Divider(),
                      Container(
                        child: Card(
                          margin: EdgeInsets.symmetric(vertical: 3),
                          elevation: 3,
// shape: RoundedRectangleBorder(
//   borderRadius: BorderRadius.circular(10),
// ),
                          color: Colors.white,
                          shadowColor: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
//Icon(Icons.medical_information),
                                    Text(
                                      "Lab Description",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Column(
                                  children: [
                                    ExpandableText(
                                      labprofile.labdescription,
                                      expandText: 'show more',
                                      collapseText: 'show less',
                                      maxLines: 3,
                                      linkColor: Colors.blueAccent,
                                      animation: true,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Divider(),
                      ElevatedButton(

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return book_test_patient(snapshot.data!.id);
                            }),
                          );
                          print(snapshot.data!.id);
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
                      Divider(),
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
                        future: apireviews.fetchReviewsbyIDLab(widget.id),
                        builder: (BuildContext context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Center(child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Center(
                                child: Text('Error: ${snapshot.error}'));
                          } else if (snapshot.hasData) {
                            List<Reviewlab> reviews = snapshot.data!['reviews'];
                          //  double averageRating = snapshot.data!['avg'];
                            //final review = snapshot.data;
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
                                              children: [
                                                Row(
                                                  children: [
                                                    SmoothStarRating(
                                                      rating: reviews[i]
                                                          .rating
                                                          .toDouble(),
                                                      // rating: averageRating,
                                                      size: 20,
                                                      filledIconData: Icons
                                                          .star_rate_rounded,

                                                      defaultIconData: Icons
                                                          .star_border_rounded,

                                                      starCount: 5,

                                                      allowHalfRating: false,
                                                      spacing: 3,
                                                      color: Colors.amber,
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                        child: new Text(
                                                      reviews[i].text,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    )),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      reviews[i].name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          fontSize: 12,
                                                          color:
                                                              Colors.black54),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),


                                      );
                                    }));
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
    );
  }
}
