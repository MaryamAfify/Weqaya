import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'docappoin.dart';

class doctor extends StatefulWidget {
  const doctor({super.key});

  @override
  State<doctor> createState() => _doctorState();
}

class _doctorState extends State<doctor> {
  List doctors = [
    {"name": "Maryam Afify", "spec": "Dermataolgy"},
    {"name": "Ahmed Afify", "spec": "Dermataolgy"},
    {"name": "Sara Ahmed", "spec": "Dermataolgy"},
    {"name": "Khaled Mohamed", "spec": "Dermataolgy"},
    {"name": "Youssef Ahmed", "spec": "Dentist"},
    {"name": "Ahmed Afify", "spec": "Dermataolgy"},
    {"name": "Maryam Afify", "spec": "Dentist"},
    {"name": "Ahmed Afify", "spec": "Dermataolgy"},
  ];
  List foundDoctors = [];
  @override
  void initState() {
    foundDoctors = doctors;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List result = [];
    if (enteredKeyword.isEmpty) {
      result = doctors;
    } else {
      result = doctors
          .where((user) =>
              user["name"].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();

      // we use the lower case method to make it case insensitive
    }
    setState(() {
      foundDoctors = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Select Doctor"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10,
          ),
          TextField(
            onChanged: (value) {
              return _runFilter(value);
            },
            decoration: InputDecoration(
              labelText: 'Search',
              suffixIcon: Icon(Icons.search),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: foundDoctors.length,
                itemBuilder: ((context, i) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      margin: EdgeInsets.symmetric(vertical: 3),
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
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
                                  backgroundImage: const NetworkImage(
                                      'https://cdn-icons-png.flaticon.com/512/387/387561.png'),
                                ),
                                Column(
                                  children: [
                                    Text("${foundDoctors[i]['name']}"),
                                    Text("${foundDoctors[i]['spec']}"),
                                    Row(
                                      children: const [
                                        Icon(Icons.star_rounded,
                                            color: Colors.amber),
                                        Icon(Icons.star_rounded,
                                            color: Colors.amber),
                                        Icon(Icons.star_rounded,
                                            color: Colors.amber),
                                        Icon(Icons.star_rounded,
                                            color: Colors.amber),
                                        Icon(Icons.star_border_rounded),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text("120 Reviews"),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.location_on_outlined,
                                      size: 20,
                                      color: Colors.cyan,
                                    ),
                                    Text("Location:Giza"),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(
                                      Icons.attach_money_rounded,
                                      size: 20,
                                      color: Colors.cyan,
                                    ),
                                    Text("fees:300 EGP")
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: Colors.grey.shade300),
                                      width: 200,
                                      height: 32,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          "Available everyday from 8 am to 4 am",
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.black38),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20,
                                    ),
                                    CircleAvatar(
                                      backgroundColor:
                                          Color.fromARGB(255, 3, 114, 205),
                                      child: IconButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) {
                                              return docbook("${doctors[i]['name']}","${doctors[i]['spec']}");
                                            }),
                                          );
                                        },
                                        icon: Icon(Icons.arrow_forward),
                                        color: Colors.white,
                                        highlightColor: Colors.pink,
                                        splashColor: Colors.blueAccent,
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
                  );
                })),
          )
        ],
      ),
    );
  }
}
