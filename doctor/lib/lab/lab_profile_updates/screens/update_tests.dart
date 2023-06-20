import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class UpdateTestsForLab extends StatefulWidget {

  @override
  State<UpdateTestsForLab> createState() => _UpdateTestsForLabState();
}

class _UpdateTestsForLabState extends State<UpdateTestsForLab> {
  List<Map<String, dynamic>> checkboxList = [
    {'id': 10, 'title': 'CBC Test', 'value': false, 'numValue': 1},
    {'id': 9, 'title': 'TSH Free T4 Test', 'value': false, 'numValue': 2},
    {'id': 8, 'title': 'Fundus Examination Test', 'value': false, 'numValue': 3},
    {'id': 7, 'title': 'GFR Renal Test', 'value': false, 'numValue': 4},
    {'id': 6, 'title': 'HbA1c Test', 'value': false, 'numValue': 5},
    {'id': 5, 'title': '2 HPP Blood Glucose Test', 'value': false, 'numValue': 6},
    {'id': 4, 'title': 'Blood Sugar Fasting Test', 'value': false, 'numValue': 7},
    {'id': 3, 'title': 'Cholesterol Test', 'value': false, 'numValue': 8},
    {'id': 1, 'title': 'Diabetes Test', 'value': false, 'numValue': 10},
  ];

  Future<void> updateDataToServer(int id, double price) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? token = pref.getString('token');
    List<Map<String, dynamic>> selectedTests = checkboxList
        .where((test) => test['value'] == true)
        .toList();

    List<Map<String, dynamic>> updatedTests = [];

    for (var test in selectedTests) {
      int? id = test['id'];
      double? price = test['numValue'].toDouble();

      if (id != null && price != null) {
        Map<String, dynamic> updatedTest = {'id': id, 'price': price};
        updatedTests.add(updatedTest);
      }
    }

    var body = json.encode(updatedTests);

    final response = await http.post(
      Uri.parse('http://hadyahmed-001-site1.ctempurl.com/api/Lab/ChooseTest/ChooseTests''?testId=$id&price=$price'),
      headers: <String, String>{
        'Content-Type': 'application/json;charset=utf-8',
        'Authorization': 'Bearer $token'
      },
      body: body,
    );

    if (response.statusCode == 200) {
      // Handle successful update
      print('Data updated successfully');
    } else {
      // Handle error
      print('Failed to update data. Error: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,
          title: Text("Choose Available Tests"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            width: 400,
            height: 700,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    width: 380,
                    height: 550,
                    child: ListView.builder(
                      itemCount: checkboxList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Column(
                          children: [
                            CheckboxListTile(
                              title: Text(checkboxList[index]['title']),
                              value: checkboxList[index]['value'],
                              onChanged: (newValue) {
                                setState(() {
                                  checkboxList[index]['value'] = newValue;
                                });
                              },
                            ),
                            Visibility(
                              visible: checkboxList[index]['value'],
                              child: Row(
                                children: [
                                  Container(
                                    width: 200,
                                    child: TextField(
                                      decoration: InputDecoration(
                                          labelText: 'Enter The Price',
                                          contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                                          prefixIcon: Icon(Icons.attach_money),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide(color: Colors.black12,width:5),
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          )
                                      ),
                                      keyboardType: TextInputType.number,
                                      onChanged: (newNum) {
                                        setState(() {
                                          checkboxList[index]['numValue'] = int.parse(newNum);
                                        });
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 30,),
                                  Container(
                                    width : 80,
                                    child: MaterialButton(onPressed: (){
                                      int? intValue = checkboxList[index]['id'];
                                      double? doublePrice;

                                      if (intValue != null) {
                                        dynamic value = checkboxList[index]['numValue'];
                                        if (value != null) {
                                          String stringPrice = value.toString();
                                          doublePrice = double.tryParse(stringPrice);
                                        }
                                      }

                                      if (intValue != null && doublePrice != null) {
                                        updateDataToServer( intValue, doublePrice);
                                      }


                                    },
                                      child: Text("add"),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 40,),

                ],
              ),
            ),
          ),
        )
    );
  }
}