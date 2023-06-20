import 'package:flutter/material.dart';

import '../../styles/colors.dart';
class history extends StatefulWidget {
  const history({Key? key}) : super(key: key);

  @override
  State<history> createState() => _historyState();
}

class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
        centerTitle: true,
        backgroundColor: defaultColor,
      ),
      body: Container(child: Text("history"),),
    );
  }
}
