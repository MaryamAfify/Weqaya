import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../Animationss/animationLogo.dart';
import 'get_tests.dart';

class  book_test extends StatefulWidget {


  @override
  State<book_test> createState() => _book_testState();
}

class _book_testState extends State<book_test> {
  List<Test> selectedTests = [];
  @override
  final Apilabtests apiLabTests = Apilabtests();
  int? id;
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,
          centerTitle: true,
          title: Text('Lab Tests'),
        ),
        body: Center(
          child: FutureBuilder<List<Test>>(
            future: apiLabTests.getLabTests(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Test>? tests = snapshot.data;
                return ListView.builder(
                  itemCount: tests!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: (() {
                        Fluttertoast.showToast(
                          msg: 'You Cant Book A Test!', // Message to be displayed
                          toastLength: Toast.LENGTH_SHORT, // Duration for which the toast will be visible
                          timeInSecForIosWeb: 3,
                          gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
                          backgroundColor: Colors.grey[700], // Background color of the toast
                          textColor: Colors.white, // Text color of the toast
                        );
                      }),
                      child:Container(
                        width: 358,
                        height: 56,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: profilesColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade100,
                              blurRadius: 2.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0), // shadow direction: bottom right
                            )
                          ],
                        ),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the start (left) side
                                mainAxisAlignment: MainAxisAlignment.center, // Vertically center the content
                                children: [
                                  Text(
                                    snapshot.data![i].name,
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  SizedBox(height: 5), // Add some spacing between the texts
                                  Row(
                                    children: [
                                      Icon(Icons.attach_money_rounded,size: 16,color:Colors.blueAccent ),
                                     
                                      SizedBox(width: 5),
                                      Text(
                                        snapshot.data![i].price.toString(),
                                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Icon(Icons.keyboard_arrow_right_rounded),
                          ],
                        ),
                      ),

                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              }
              return Center(child: LogoAnimation(),);
            },
          ),
        ),
    );
  }
}