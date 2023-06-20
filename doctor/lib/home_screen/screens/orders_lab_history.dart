
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';

import '../../Animationss/animationLogo.dart';
import '../../lab/lab_profile_updates/lab_profile.dart';
import '../../lab/lab_profile_updates/screens/api_for_update/get_lab_profile_class.dart';
import '../../lab/lab_review/reviewDialog.dart';
import '../../styles/colors.dart';
import '../api_orders/api_orders_lab.dart';

class lab_orders_history extends StatefulWidget {
  const lab_orders_history({Key? key}) : super(key: key);

  @override
  State<lab_orders_history> createState() => _lab_orders_historyState();
}

class _lab_orders_historyState extends State<lab_orders_history> {
  List patients = [
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade100,
        body: FutureBuilder<List<labslist>>(
          future: apiviewlabs.fetchHistoryLabList(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: LogoAnimation(),);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final lab = snapshot.data;

              return Center(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                          itemCount: lab!.length,
                          itemBuilder: (context, i) {

                            return Container(
                              margin: EdgeInsets.fromLTRB(10, 20, 10, 0),
                              decoration: BoxDecoration(
                                border:
                                Border.all(width: 1, color: Colors.black12),
                                color: Colors.white70,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10),
                                ),
                              ),
                              child: Column(
                                children: [
                                  ListTile(
                                    leading: CircleAvatar(
                                      backgroundColor: Colors.white,
                                       backgroundImage:
                                        snapshot.data![i].photo != null
                                           ? MemoryImage(
                                               snapshot.data![i].photo!)
                                            : null,
                                    ),
                                    title: Text(
                                      lab[i].labname,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    trailing: RichText(
                                      text: TextSpan(
                                        text: lab[i].statusNum == 1
                                            ? 'Completed'
                                            : 'Cancled',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: lab[i].statusNum == 1
                                              ? Colors.green
                                              : Colors.red,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.location_on_sharp),
                                            SizedBox(
                                              width: 20,
                                            ),
                                            Text(lab[i].area),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                                children :[
                                                  Icon(Icons.local_hospital_outlined),
                                                  SizedBox(width: 20,),
                                                  Text(
                                                    lab[i].testname,
                                                  ),
                                                ]),
                                          ],
                                        ),
                                        Row(
                                            children :[
                                              Icon(Icons.attach_money_rounded),
                                              SizedBox(width: 20,),
                                              Text("price : "),
                                              Text(
                                                "${lab[i].price}",
                                              ),
                                            ]),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 30,
                                          child: MaterialButton(
                                            color: defaultColor,
                                            padding: EdgeInsets.all(5.0),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(30.0),
                                            ),
                                            child: Text(
                                              "Lab Profile",
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                            onPressed: () {
                                              Navigator.push(context,
                                                  MaterialPageRoute(
                                                      builder: (context) {
                                                        return Lab_profile(lab[i].labid);
                                                      }));
                                            },
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        if (lab[i].statusNum == 1)
                                          Container(
                                            width: 120,
                                            height: 30,
                                            child: MaterialButton(
                                              color: defaultColor,
                                              padding: EdgeInsets.all(5.0),
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(30.0),
                                              ),
                                              child: Text(
                                                "Review Lab",
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                              onPressed: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      ReviewDialog(lab[i].labid),
                                                );
                                              },
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              );
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ));
  }
}