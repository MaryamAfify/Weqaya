import 'package:flutter/material.dart';

class city extends StatefulWidget {
  const city({super.key});

  @override
  State<city> createState() => _cityState();
}

class _cityState extends State<city> {
  List cities = [
    {"name": "All"},
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
    {"name": "Ramsis"},
    {"name": "Down Town"},
    {"name": "Kasr al Ainy"},
    {"name": "10th of Ramadan"},
  ];
  late List<bool> isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = List<bool>.filled(cities.length, false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Select Area",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
          child: ListView.builder(
              itemCount: cities.length,
              itemBuilder: (context, i) {
                return Container(
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
                      Checkbox(
                          value: isChecked[i],
                          onChanged: (value) {
                            setState(() {
                              isChecked[i] = value!;
                            });
                          }),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "${cities[i]['name']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                     
                    ],
                  ),
                );
              })),
    );
  }
}
