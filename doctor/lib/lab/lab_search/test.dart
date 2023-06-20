import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';

import 'area.dart';

class Tests extends StatefulWidget {

  @override
  State<Tests> createState() => _TestsState();
}

class _TestsState extends State<Tests> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> labTests = [
    {"name": "CBC"},
    {"name": "TSH Free T4"},
    {"name": "Fundus Examination"},
    {"name": "GFR Renal"},
    {"name": "HbA1c"},
    {"name": "2 HPP Blood Glucose"},
    {"name": "Blood Sugar Fasting"},
    {"name": "Cholesterol"},
    {"name": "Cardiac Risk"},
    {"name": "Diabetes"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: const Text(
          "Lab Tests",
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
                      hintText: 'Search For A Test',
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
              itemCount: labTests.length,
              itemBuilder: (context, index) {
                final testName = labTests[index]['name'];

                if (searchController.text.isNotEmpty &&
                    !testName!.toLowerCase().contains(searchController.text.toLowerCase())) {
                  return Container(); // Skip rendering if not a match
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return Lab_city(testName);
                      }),
                    );
                  },
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
                      ],
                    ),
                    margin: EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            testName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Spacer(),
                        Icon((Icons.keyboard_arrow_right_rounded)),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
