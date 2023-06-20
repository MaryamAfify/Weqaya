import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:smooth_star_rating_null_safety/smooth_star_rating_null_safety.dart';

import '../../Animationss/animationLogo.dart';
import '../lab_profile_updates/lab_profile.dart';
import 'api_lab_search/api.dart';
import 'api_lab_search/lab.dart';

class lab_by_recommendation_or_by_search extends StatefulWidget {
  const lab_by_recommendation_or_by_search(this.area, this.test, {Key? key})
      : super(key: key);

  final String area;
  final String test;

  @override
  State<lab_by_recommendation_or_by_search> createState() =>
      _lab_by_recommendation_or_by_searchState();
}

class _lab_by_recommendation_or_by_searchState
    extends State<lab_by_recommendation_or_by_search> {
  int? id;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: Text("Select Lab"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(height: 5),
          FutureBuilder<List<lab>>(
              future: Apilab.getLabs(widget.area, widget.test),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Expanded(
                    child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return InkWell(
                            onTap: () {
                              // Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                              //   return city();
                              // }));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.grey.shade300,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.shade300,
                                    blurRadius: 2,
                                    offset: Offset(3, 3),
                                    spreadRadius: 1.5,
                                  ),
                                ],
                              ),
                              margin: EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(10),
                                    child: CircleAvatar(
                                      backgroundColor: Colors.white,
                                      backgroundImage:
                                          snapshot.data![i].photo != null
                                              ? MemoryImage(
                                                  snapshot.data![i].photo!)
                                              : null,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          snapshot.data![i].name,
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                      Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.location_on,
                                                  color: defaultColor,
                                                  size: 15,
                                                ),
                                                Text(
                                                  snapshot.data![i].area,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            SmoothStarRating(
                                              rating: snapshot.data![i].avg,
                                              // rating: averageRating,
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
                                      )
                                    ],
                                  ),
                                  new Spacer(),
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) {
                                            return Lab_profile(
                                                snapshot.data![i].id);

                                            // "${doctors[i]['name']}",
                                            // "${doctors[i]['spec']}");
                                          }),
                                        );
                                      },
                                      icon: Icon(Icons.arrow_forward),
                                      color: Colors.white,
                                      highlightColor: Colors.pink,
                                      splashColor: Colors.blueAccent,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  );
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }
                return Center(child: LogoAnimation(),);
              })
        ],
      ),
    );
  }
}
