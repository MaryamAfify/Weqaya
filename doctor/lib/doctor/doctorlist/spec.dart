import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';

import 'area.dart';

class spec extends StatefulWidget {
  const spec({super.key});

  @override
  State<spec> createState() => _specState();
}

// ignore: camel_case_types
class _specState extends State<spec> {
  TextEditingController searchController = TextEditingController();
  List specia = [
    {"name": "Dermatology"},
    {"name": "Dentistry"},
    {"name": "Neurology"},
    {"name": "Pediatrics and New Borns"},
    {"name": "Cardiology and Vascular"},
    {"name": "Psychiatry"},
    {"name": "Ear,Nose and Throat"},
    {"name": "Internal Medicine"},
    {"name": "Orthopedics"},
    {"name": "Gynaecology and Infertility"},
    {"name": "Allergy and Immunology"},
    {"name": "Diabetes and Endocrinology"},
    {"name": "Nutrition"},
    {"name": "Chest and Respiratory"},
    {"name": "Familiy Medicine"},
    {"name": "Nephrology"},
    {"name": "Opthalmology"},
    {"name": "Urology"},
    {"name": "Hematology"},
    {"name": "Hepatology"},
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        title: const Text(
          "Clinic Vist",
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
                  itemCount: specia.length,
                  itemBuilder: (context, i) {
                    final specName = specia[i]['name'];

                    if (searchController.text.isNotEmpty &&
                        !specName!.toLowerCase().contains(searchController.text.toLowerCase())) {
                      return Container(); // Skip rendering if not a match
                    }
                    return InkWell(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) {
                            return city( "${specia[i]['name']}");
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
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${specia[i]['name']}",
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                            new Spacer(),
                            Icon((Icons.keyboard_arrow_right_rounded)),
                          ],
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ),

    );
  }
}
