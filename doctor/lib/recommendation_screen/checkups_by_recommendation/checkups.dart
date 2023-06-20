
import 'package:flutter/material.dart';
import 'package:path/path.dart';

import '../../Animationss/animationLogo.dart';
import '../../lab/lab_search/area.dart';
import '../../styles/colors.dart';
import '../recommendation_api/get_recommendation.dart';
class checkups extends StatefulWidget {
  const checkups({Key? key}) : super(key: key);

  @override
  State<checkups> createState() => _checkupsState();
}

class _checkupsState extends State<checkups> {
  List tests = [
  //  {"name": "CBC"},
  //  {"name": "RFT"},


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: Container(
        child: Center(
          child: Text("Recommendation Tests"),),
      ),),
      body:   Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 0, 20),
            alignment: Alignment.topLeft,
            child: Text("Tests",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          Flexible(
            child: FutureBuilder<List<recomm>>(
                future: Api.getrecomm(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: (() {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => Lab_city(snapshot.data![i].name),
                                  ),
                                );
                              }),
                              child: Container(
                                width: 358,
                                height: 56,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  color: profilesColor,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 2.0,
                                      spreadRadius: 0.0,
                                      offset: Offset(2.0, 2.0), // shadow direction: bottom right
                                    )
                                  ],
                                ),
                                margin: EdgeInsets.all(10),
                                child: Row(
                                  children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            snapshot.data![i].name,
                                            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    ),
                                    new Spacer(),
                                    Icon((Icons.keyboard_arrow_right_rounded)),
                                  ],
                                ),
                              ),
                            );
                          });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child: LogoAnimation(),);
                }),
          ),
        ],
      ),
    );
  }
}