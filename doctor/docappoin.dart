import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'doctor.dart';

class docbook extends StatefulWidget {
  const docbook(this.name, this.speciality, {super.key});
  final String name;
  final String speciality;

  @override
  State<docbook> createState() => _docbookState();
}

class _docbookState extends State<docbook> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Doctor profile"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            margin: EdgeInsets.all(5),
            height: 300,
            width: 400,
            child: Column(
              children: [
                Card(
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
                                    Text(widget.name),
                                    Text(widget.speciality),
                                    Row(
                                      children: const [
                                        Icon(Icons.star_rounded, color: Colors.amber),
                                        Icon(Icons.star_rounded, color: Colors.amber),
                                        Icon(Icons.star_rounded, color: Colors.amber),
                                        Icon(Icons.star_rounded, color: Colors.amber),
                                        Icon(Icons.star_border_rounded),
                                        SizedBox(
                                          width: 30,
                                        ),
                                        Text("120 Reviews"),
                                      ],
                                    )
                                  ],
                                ),
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
                              ],
                            ),
                          ],
                        ))),
              ],
            ),
          ),
        ));
  }
}
