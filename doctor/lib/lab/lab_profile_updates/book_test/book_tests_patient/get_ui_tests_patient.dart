import 'package:doctor/lab/confrim/Confirm.dart';
import 'package:doctor/lab/lab_profile_updates/book_test/book_tests_patient/gettests_byid.dart';
import 'package:flutter/material.dart';

import '../../../../Animationss/animationLogo.dart';
import '../../../../styles/colors.dart';

class book_test_patient extends StatefulWidget {
  const book_test_patient(this.id, {Key? key}) : super(key: key);
  final int id;

  @override
  State<book_test_patient> createState() => _book_test_patientState();
}

class _book_test_patientState extends State<book_test_patient> {
  List<Tuple2<Test, bool>> selectedTests = [];

  @override
  final Apilabtestsforpatient apiLabTests = Apilabtestsforpatient();
  int? id; // Add the labid property

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: defaultColor,
        centerTitle: true,
        title: Text('Lab Tests'),
      ),
      body: Center(
        child: FutureBuilder<List<Test>>(
          future: Apilabtestsforpatient.getLabTestsforpatient(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<Test>? tests = snapshot.data;
              return  ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, i) {
                    return InkWell(
                      onTap: (() {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => confirm_lab(
                              widget.id,
                                snapshot.data![i].idtest,
                              snapshot.data![i].name ,
                              snapshot.data![i].price ,
                            ),
                          ),
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
                  });
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            return Center(child: LogoAnimation(),);
          },
        ),

      ),
    );
  }

  double calculateTotalPrice(List<Tuple2<Test, bool>> selectedTests) {
    double totalPrice = 0;
    for (var tuple in selectedTests) {
      if (tuple.item2) {
        totalPrice += tuple.item1.price;
      }
    }
    return totalPrice;
  }
}

class Tuple2<T1, T2> {
  final T1 item1;
  final T2 item2;

  Tuple2(this.item1, this.item2);
}
