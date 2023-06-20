import 'package:doctor/doctor/doctorlist/extra_spec.dart';
import 'package:flutter/material.dart';

import '../../../lab/lab_search/tests...dart';
import '../../../styles/colors.dart';

class Search_lab_doctor extends StatefulWidget {
  const Search_lab_doctor({Key? key}) : super(key: key);

  @override
  State<Search_lab_doctor> createState() =>
      _Search_lab_doctorState();
}

class _Search_lab_doctorState
    extends State<Search_lab_doctor>  with TickerProviderStateMixin{
  late TabController _tabController;

  final List<Widget> _tabs = [
   testsss(),
 extra_spec()
  ];

  final List<String> _tabTitles = [
    'Tests',
    'Specialty',
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
