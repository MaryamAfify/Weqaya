import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import '../../Animationss/animationLogo.dart';
import '../../doctor/api_doctor/api.dart';
import '../../doctor/api_doctor/doctor3 (1).dart';
import '../../styles/colors.dart';
class doctor_notes extends StatefulWidget {
  const doctor_notes({Key? key}) : super(key: key);

  @override
  State<doctor_notes> createState() => _doctor_notesState();
}

class _doctor_notesState extends State<doctor_notes> {
  @override
  List tests = [
    //  {"name": "CBC"},
    //  {"name": "RFT"},


  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Column(
        children: [
          Container(
            margin: EdgeInsets.fromLTRB(10, 30, 0, 20),
            alignment: Alignment.topLeft,
            child: Text("Your prescribtions from Doctors",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          Flexible(
            child: FutureBuilder<List<Doctor3>>(
                future: Api.fetchBookedDoctorsCompleted(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return
                      ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return InkWell(
                              onTap: (() {
                              }),
                              child: Container(
                                width: 380,
                                height: 60,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
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
                                        Text(
                                          snapshot.data![i].name,
                                          style: TextStyle(fontWeight: FontWeight.bold,fontSize: 13),
                                        ),
                                        SizedBox(height: 10,),
                                        Text(
                                          snapshot.data![i].result,
                                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 10),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),

                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          });
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return Center(child:  LogoAnimation());
                }),
          ),
        ],
      ),
    );
  }
}