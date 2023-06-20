import 'package:doctor/Animationss/animationLogo.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import '../api_orders/api_orders_lab.dart';
class result extends StatefulWidget {
  const result({Key? key}) : super(key: key);

  @override
  State<result> createState() => _resultState();
}

class _resultState extends State<result> {
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
            child: Text("Your notes from Labs",
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
          ),
          Flexible(
            child: FutureBuilder<List<labslist>>(
                future: apiviewlabs.fetchHistoryLabList(),
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
                                            snapshot.data![i].labname,
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