import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';

import 'doctorsList.dart';
class city extends StatefulWidget {
  const city(this.area, {super.key});

  final String area;

  @override
  State<city> createState() => _cityState();
}

class _cityState extends State<city> {
  TextEditingController searchController = TextEditingController();
  List cities = [
    {"name": "Giza"},
    {"name": "Haram"},
    {"name": "Faisal"},
    {"name": "Dokki"},
    {"name": "Mohandsen"},
    {"name": "6 of October"},
    {"name": "Nasr City"},
    {"name": "Agouza"},
    {"name": "New Cairo"},
    {"name": "Abbasya"},
    {"name": "Ghamra"},
    {"name": "Ramses"},
    {"name": "Down Town"},
    {"name": "Kasr al Ainy"},
    {"name": "10th of Ramadan"},
  ];
  late List<bool> isChecked;

  @override
  /* void initState() {
    super.initState();
    isChecked = List<bool>.filled(cities.length, false);
  } */

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: const Text(
          "Select Area",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
        Container(
        alignment: Alignment.topLeft,
        width: 357,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40.0),
          color: Colors.grey[200],
        ),
        margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search),
            SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: searchController,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Search For A City',
                ),
                onChanged: (value) {
                  setState(() {}); // Trigger rebuild on text change
                },
              ),
            ),
          ],
        ),
      ),
          Expanded(
            child: ListView.builder(
                    itemCount: cities.length,
                    itemBuilder: (context, i) {
                      final cityName = cities[i]['name'];

                      if (searchController.text.isNotEmpty &&
                          !cityName!.toLowerCase().contains(searchController.text.toLowerCase())) {
                        return Container(); // Skip rendering if not a match
                      }
                      return InkWell(
                        onTap: (() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) {
                              return doctorList(widget.area,"${cities[i]['name']}");
                            }),
                          );
                        }),
                        child: Container(
                          height: 50,
                          decoration: BoxDecoration(
                              color: Colors.white,
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
                              ]),
                          margin: EdgeInsets.all(10),
                          child: Row(
                            children: [
                              /* Checkbox(
                                  value: isChecked[i],
                                  onChanged: (value) {
                                    setState(() {
                                      isChecked[i] = value!;
                                    });
                                  }), */
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "${cities[i]['name']}",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
          )
        ],)
    );
  }
}
