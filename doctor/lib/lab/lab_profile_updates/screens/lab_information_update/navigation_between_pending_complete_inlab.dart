import 'package:doctor/home_screen/screens/history.dart';
import 'package:doctor/home_screen/screens/homescreen.dart';
import 'package:doctor/home_screen/screens/notification.dart';
import 'package:doctor/home_screen/screens/orders_lab.dart';
import 'package:doctor/home_screen/screens/profile.dart';
import 'package:doctor/lab/lab_profile_updates/screens/history_lab.dart';
import 'package:doctor/lab/lab_profile_updates/screens/myPatients.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';

class navigation_in_lab extends StatefulWidget {
  const navigation_in_lab({Key? key}) : super(key: key);

  @override
  State<navigation_in_lab> createState() => _navigation_in_labState();
}

class _navigation_in_labState extends State<navigation_in_lab> {
  int index = 0;
  final pages = [
    myPatients_lab(),
    myPatients_lab_history()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("My Patients"),
      centerTitle: true,
        backgroundColor: defaultColor,
      ),
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
            icon: Icon(Icons.work_history_rounded),
            label: 'History',
          ),
          NavigationDestination(
            icon: Icon(Icons.local_hospital_outlined),
            label: 'Orders',
          ),
        ],
      ),

    );
  }
}