import 'package:doctor/Lab_Form/list_lab_inform/list_lab_inform.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'Animationss/splash.dart';
import 'DoctorView/doctorForm.dart';
import 'Lab_Form/Lab_Form.dart';
import 'auth_screen/login.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  initializeDateFormatting('en', '').then((value) => null);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}


class _MyAppState extends State<MyApp> {
  @override
  initState() {
    super.initState();

  
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weqaya',
      theme: ThemeData(
          primarySwatch: Colors.blue,
          canvasColor: Colors.white,
          textTheme: const TextTheme()),
     /// home: LoginPage(),
     /// 
     /// 
        initialRoute: '/splash',
      routes: {
        '/splash': (context) => SplashScreen(),
        '/login': (context) => LoginPage(),
        // Add more routes for your other screens/pages
      },
    );
  }
}
//import 'package:flutter/material.dart';

//void main() {
 // runApp(MyApp());
//}

//class MyApp extends StatefulWidget {
 // @override
 // _MyAppState createState() => _MyAppState();
//}

//class _MyAppState extends State<MyApp> {
 // bool diabetestest = false;
 // bool cardiacrisk = false;
 // bool cholestroltest = false;
 // bool bloodsugarfastingtest = false;
 // bool hppbloodglucosetest = false;
 // bool hba1ctest = false;
 // bool gfrrenaltest = false;
 // bool fundusexaminationtest = false;
 // bool tshfreet4test = false;
 // bool cbctest = false;

 // @override
 // Widget build(BuildContext context) {
   // return MaterialApp(
     // title: 'Checkbox Example',
     // home: Scaffold(
      //  appBar: AppBar(
      //    title: Text('Checkbox Example'),
     //   ),
   //     body: Column(
          //  mainAxisAlignment: MainAxisAlignment.center,
           // children: [
             // Row(
               // children: [
               //   Checkbox(
                 //   activeColor: Colors.black,
                 //   value: diabetestest,
                   // onChanged: (bool? value) {
                   //   setState(() {
                  //      diabetestest = value!;
                 //     });
                //    },
               //   ),
               //   Text('Diabetes Test'),
               //   SizedBox(width: 20,),
                //  Container(
                 //   width: 130,
                  //  height: 30,
                  //  child: Visibility(
                     // visible: diabetestest,
                     // child: TextFormField(
                       // decoration: InputDecoration(
                         //   contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                          //  hintText: "Price",
                         //   prefixIcon: Icon(Icons.attach_money),
                         //   border: OutlineInputBorder(
                       //         borderSide: BorderSide(color: Colors.black12,width:5),
                     //           borderRadius: BorderRadius.all(Radius.circular(10))
                    //        )
                  //      ),
                 //     ),
               //     ),
              //    ),
             //   ],
            //  ),
             // SizedBox(height: 10,),
             // Row(
               // children: [
                //  Checkbox(
                 //   value: cardiacrisk,
                 //   onChanged: (bool? value) {
                  //    setState(() {
                  //      cardiacrisk= value!;
                 //     });
                //    },
               //   ),
                //  Text('Cardiac Risk'),
                //  SizedBox(width: 20,),
                //  Container(
                 //   width: 130,
                  //  height: 30,
                   // child: Visibility(
                    //  visible: cardiacrisk,
                     // child: TextFormField(
                      //  decoration: InputDecoration(
                       //     contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        //    hintText: "Price",
                        //    prefixIcon: Icon(Icons.attach_money),
                      //      border: OutlineInputBorder(
                    //            borderSide: BorderSide(color: Colors.black12,width:5),
                  //              borderRadius: BorderRadius.all(Radius.circular(10))
                   //         )
                  //      ),
                //      ),
              //      ),
              //    ),
            //    ],
          //    ),
          //    SizedBox(height: 10,),
           //   Row(
            //    children: [
              //    Checkbox(
               //     value: cholestroltest,
               //     onChanged: (bool? value) {
               //       setState(() {
               //         cholestroltest = value!;
              //        });
             //       },
            //      ),
             //     Text('Cholestrol Test'),
               //   SizedBox(width: 20,),
               //   Container(
                //    width: 130,
                 //   height: 30,
                //    child: Visibility(
                //      visible: cholestroltest,
                    //  child: TextFormField(
                     //   decoration: InputDecoration(
                     //       contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                       //     hintText: "Price",
                       //     prefixIcon: Icon(Icons.attach_money),
                       //     border: OutlineInputBorder(
                      //          borderSide: BorderSide(color: Colors.black12,width:5),
                     //           borderRadius: BorderRadius.all(Radius.circular(10))
                   //         )
                 //       ),
                //      ),
               //     ),
             //     ),
             //   ],
           //   ),
            //  SizedBox(height: 10,),
            //  Row(
              //  children: [
                 // Checkbox(
                  //  value: bloodsugarfastingtest,
                   // onChanged: (bool? value) {
                    //  setState(() {
                     //  bloodsugarfastingtest = value!;
                    //  });
                  //  },
                //  ),
               //   Text('Blood Sugar Fasting Test'),
              //    SizedBox(width: 20,),
               //   Container(
                //    width: 130,
                //    height: 30,
                 //   child: Visibility(
                //      visible: bloodsugarfastingtest,
                    //  child: TextFormField(
                      //  decoration: InputDecoration(
                        //    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                           // hintText: "Price",
                          //  prefixIcon: Icon(Icons.attach_money),
                          //  border: OutlineInputBorder(
                            //    borderSide: BorderSide(color: Colors.black12,width:5),
                          //      borderRadius: BorderRadius.all(Radius.circular(10))
                        //    )
                      //  ),
                    //  ),
                  //  ),
                //  ),
              //  ],
            //  ),
             // SizedBox(height: 10,),
             // Row(
               // children: [
               //   Checkbox(
                 //   value: hppbloodglucosetest,
                  //  onChanged: (bool? value) {
                  //    setState(() {
                   //     hppbloodglucosetest = value!;
                  //    });
                 //   },
                //  ),
                //  Text('2 HPP Blood Glucose Test'),
                //  SizedBox(width: 20,),
                //  Container(
                  //  width: 130,
                  //  height: 30,
                   // child: Visibility(
                    //  visible: hppbloodglucosetest,
                    //  child: TextFormField(
                      //  decoration: InputDecoration(
                        //    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                         //   hintText: "Price",
                        //    prefixIcon: Icon(Icons.attach_money),
                       //     border: OutlineInputBorder(
                       //         borderSide: BorderSide(color: Colors.black12,width:5),
                     //           borderRadius: BorderRadius.all(Radius.circular(10))
                   //         )
                 //       ),
                //      ),
               //     ),
             //     ),
            //    ],
            //  ),
             // SizedBox(height: 10,),
             // Row(
               // children: [
                 // Checkbox(
                  //  value: hba1ctest,
                 //   onChanged: (bool? value) {
                   //   setState(() {
                  //      hba1ctest = value!;
                 //     });
                //    },
               //   ),
                //  Text('HbA1c Test'),
                //  SizedBox(width: 20,),
                //  Container(
                  //  width: 130,
                 //   height: 30,
                  //  child: Visibility(
                    //  visible: hba1ctest,
                    //  child: TextFormField(
                    //    decoration: InputDecoration(
                          //  contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                         //   hintText: "Price",
                        //    prefixIcon: Icon(Icons.attach_money),
                          //  border: OutlineInputBorder(
                           //     borderSide: BorderSide(color: Colors.black12,width:5),
                         //       borderRadius: BorderRadius.all(Radius.circular(10))
                       //     )
                     //   ),
                   //   ),
                 //   ),
               //   ),
             //   ],
            //  ),
             // SizedBox(height: 10,),
             // Row(
              //  children: [
               //   Checkbox(
                   // value: gfrrenaltest,
                   // onChanged: (bool? value) {
                    //  setState(() {
                    //    gfrrenaltest = value!;
                   //   });
                  //  },
                 // ),
                //  Text('GFR Renal Test '),
                //  SizedBox(width: 20,),
                 // Container(
                   // width: 130,
                   // height: 30,
                   // child: Visibility(
                     // visible: gfrrenaltest,
                     // child: TextFormField(
                       // decoration: InputDecoration(
                        //    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                           // hintText: "Price",
                          //  prefixIcon: Icon(Icons.attach_money),
                         //   border: OutlineInputBorder(
                         //       borderSide: BorderSide(color: Colors.black12,width:5),
                       //         borderRadius: BorderRadius.all(Radius.circular(10))
                     //       )
                   //     ),
                 //     ),
               //     ),
             //     ),
            //    ],
           //   ),
            //  SizedBox(height: 10,),
             // Row(
               // children: [
                //  Checkbox(
                 //   value: fundusexaminationtest,
                  //  onChanged: (bool? value) {
                  //    setState(() {
                  //      fundusexaminationtest = value!;
                 //     });
               //     },
              //    ),
              //    Text('Fundus Examination Test'),
              //    SizedBox(width: 20,),
             //     Container(
                  //  width: 130,
                   // height: 30,
                    //child: Visibility(
                     // visible: fundusexaminationtest,
                     // child: TextFormField(
                       // decoration: InputDecoration(
                        //    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                        //    hintText: "Price",
                        //    prefixIcon: Icon(Icons.attach_money),
                      //      border: OutlineInputBorder(
                     //           borderSide: BorderSide(color: Colors.black12,width:5),
                    //            borderRadius: BorderRadius.all(Radius.circular(10))
                   //         )
                 //       ),
               //       ),
               //     ),
             //     ),
           //     ],
           //   ),
           //   SizedBox(height: 10,),
            //  Row(
              //  children: [
               //   Checkbox(
                //    value: tshfreet4test,
                 //   onChanged: (bool? value) {
                   //   setState(() {
                   //     tshfreet4test = value!;
                 //     });
               //     },
               //   ),
                //  Text('TSH Free T4 Test'),
                //  SizedBox(width: 20,),
                 // Container(
                 //   width: 130,
                //    height: 30,
                //    child: Visibility(
                //      visible: tshfreet4test,
                 //     child: TextFormField(
                  //      decoration: InputDecoration(
                   //         contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                   //         hintText: "Price",
                    //        prefixIcon: Icon(Icons.attach_money),
                    //        border: OutlineInputBorder(
                    //            borderSide: BorderSide(color: Colors.black12,width:5),
                    //            borderRadius: BorderRadius.all(Radius.circular(10))
                  //          )
                  //      ),
                //      ),
              //      ),
             //     ),
             //   ],
           //   ),
           //   SizedBox(height: 10,),
            //  Row(
             //   children: [
              //    Checkbox(
               //     value: cbctest,
                //    onChanged: (bool? value) {
                 //     setState(() {
                 //       cbctest = value!;
                 //     });
                //    },
               //   ),
               //   Text('CBC Test'),
               //   SizedBox(width: 20,),
             //     Container(
             //       width: 130,
                 //   height: 30,
                  //  child: Visibility(
                 //     visible: cbctest,
                  //    child: TextFormField(
                  //      decoration: InputDecoration(
                     //       contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                   //         hintText: "Price",
                  //          prefixIcon: Icon(Icons.attach_money),
                //            border: OutlineInputBorder(
              //                  borderSide: BorderSide(color: Colors.black12,width:5),
             //                   borderRadius: BorderRadius.all(Radius.circular(10))
            //                )
           //             ),
          //            ),
         //           ),
        //          ),
       //         ],
      //        ),
     //       ],
    //      ),
   //     ),
  //  );
 // }
//}
