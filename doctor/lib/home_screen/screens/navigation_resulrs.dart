
import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'doctor_notes.dart';
import 'notification.dart';
import 'orders_lab.dart';
import 'orders_lab_history.dart';

class results_lab_doctor extends StatefulWidget {
  const results_lab_doctor({Key? key}) : super(key: key);

  @override
  State<results_lab_doctor> createState() =>
      _results_lab_doctorState();
}

class _results_lab_doctorState
    extends State<results_lab_doctor>  with TickerProviderStateMixin{
  late TabController _tabController;

  final List<Widget> _tabs = [
   result(),
    doctor_notes(),
   // lab_orders_history()
  ];

  final List<String> _tabTitles = [
    'Lab',
    'Doctor',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Results'),
        centerTitle: true,
        backgroundColor: defaultColor,
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(20.0), // Set the preferred height of the TabBar
          child: TabBar(
            controller: _tabController,
            tabs: _tabTitles.map((title) => Tab(text: title)).toList(),
            indicatorSize: TabBarIndicatorSize.label,
            indicatorWeight: 2.0,
            labelStyle: TextStyle(fontSize: 12), // Set a smaller font size for the tab labels
          ),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs,
      ),
    );
  }
}