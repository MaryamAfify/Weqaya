import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'orders_lab.dart';
import 'orders_lab_history.dart';

class navigation_in_lab_inpatient extends StatefulWidget {
  const navigation_in_lab_inpatient({Key? key}) : super(key: key);

  @override
  State<navigation_in_lab_inpatient> createState() =>
      _navigation_in_lab_inpatientState();
}

class _navigation_in_lab_inpatientState
    extends State<navigation_in_lab_inpatient>  with TickerProviderStateMixin{
  late TabController _tabController;

  final List<Widget> _tabs = [
    lab_orders(),
    lab_orders_history()
  ];

  final List<String> _tabTitles = [
    'Orders',
    'History',
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
        title: Text("Lab"),
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





