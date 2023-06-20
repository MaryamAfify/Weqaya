import 'package:doctor/doctor/doctorlist/pendingDoctors.dart';
import 'package:flutter/material.dart';

import 'completedDoctors.dart';


class patientNavigation extends StatefulWidget {
  const patientNavigation({Key? key}) : super(key: key);

  @override
  State<patientNavigation> createState() => _patientNavigationState();
}

class _patientNavigationState extends State<patientNavigation> {
  int index = 0;
  final pages = [
    pendingDoctors(),
    completedDoctors(),
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: pages[index]),
      bottomNavigationBar: NavigationBar(
        // set index to make the mark of the bottom being where i click but i but it by default to (home) index number 2
        selectedIndex: index,
        onDestinationSelected: (index) => setState(
          () => this.index = index,
        ),
        backgroundColor: Color.fromRGBO(78, 202, 228, 0.24),
        destinations: [
          NavigationDestination(
            icon: Icon(
              Icons.info_outline,
            ),
            selectedIcon: Icon(Icons.info),
            label: 'Pending',
          ),
          NavigationDestination(
            icon: Icon(Icons.history_outlined),
            selectedIcon: Icon(Icons.history),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
