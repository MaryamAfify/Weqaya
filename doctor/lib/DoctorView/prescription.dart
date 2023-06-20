import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../doctor/api_doctor/api.dart';
class prescrip extends StatefulWidget {
  const prescrip(this.id, {super.key});

  final int id;

  @override
  State<prescrip> createState() => _prescripState();
}

class _prescripState extends State<prescrip> {
  String? pres;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: defaultColor,
          title: Text("Prescribtion")),
      body: SafeArea(
          child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    maxLines: null,

                    // Allows the text field to expand vertically based on content
                    keyboardType:
                        TextInputType.multiline, // Enables multiline input
                    decoration: InputDecoration(
                      labelText: "Rosheta",
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 16.0,
                          horizontal:
                              10), // Adjust the vertical padding as needed
                      hintText: 'enter patient note', // Placeholder text
                      border: OutlineInputBorder(
                        // Optional: Customize the border appearance
                        borderRadius: BorderRadius.circular(
                            10.0), // Adjust the border radius as needed
                        borderSide: BorderSide(
                            color: Colors
                                .grey), // Adjust the border color as needed
                      ),
                    ),
                    onChanged: (value) {
                      pres = value;
                    },
                  ))
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: () {
                    try {
                      print(widget.id);
                      print(pres);
                      Api.postNotesToPatient(pres!, widget.id);
                    } catch (e) {
                      print('Exception: $e');
                    }
                  },
                  child: Text("Sumbit"))
            ],
          ),
        ),
      )),
    );
  }
}
