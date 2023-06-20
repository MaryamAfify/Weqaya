
import 'package:doctor/home_screen/screens/homescreen.dart';
import 'package:doctor/home_screen/screens/navigation_in_patient_doctor.dart';
import 'package:doctor/home_screen/screens/navigation_in_patient_labs.dart';
import 'package:doctor/home_screen/screens/navigation_resulrs.dart';
import 'package:doctor/home_screen/screens/profile.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  const home({Key? key}) : super(key: key);

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  int index = 4;
  final pages = [
    My_Profile(),
    navigation_in_doctor_inpatient(),
    navigation_in_lab_inpatient(),
    results_lab_doctor(),
    homescreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      Container(
          child: pages[index]),

      bottomNavigationBar: NavigationBar(
        // set index to make the mark of the bottom being where i click but i but it by default to (home) index number 2
        selectedIndex: index,
        onDestinationSelected: (index) => setState(()=>this.index =index,),
        backgroundColor: Color.fromRGBO(78, 202, 228, 0.24)
      ,
        destinations : [
          NavigationDestination(
            icon: Icon(Icons.perm_contact_calendar_outlined,
            ),
            label: 'my profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.work_history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'Orders',
          ),
          NavigationDestination(
            icon: Icon(Icons.notification_add),
            label: 'Result',
          ),
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
        ],
      ),

    );
  }
}

