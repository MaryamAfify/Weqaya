import 'package:flutter/material.dart';
import '../../styles/colors.dart';
import 'lab_list.dart';

class Lab_city extends StatefulWidget {
  const Lab_city(this.area, {super.key});

  final String area;

  @override
  State<Lab_city> createState() => _Lab_cityState();
}

class _Lab_cityState extends State<Lab_city> {
  TextEditingController searchController = TextEditingController();

  List<Map<String, String>> cities = [
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
    {"name":"Mosadak"}
  ];

  @override
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
              itemBuilder: (context, index) {
                final cityName = cities[index]['name'];

                if (searchController.text.isNotEmpty &&
                    !cityName!.toLowerCase().contains(searchController.text.toLowerCase())) {
                  return Container(); // Skip rendering if not a match
                }

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) {
                        return lab_by_recommendation_or_by_search(widget.area, cityName);
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
                            cityName!,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
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
