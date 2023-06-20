import 'package:doctor/lab/lab_profile_updates/screens/api_patient_lab/api_patient_lab.dart';
import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
class notes_lab extends StatefulWidget {
  const notes_lab(this.id, {super.key});

  final int id;

  @override
  State<notes_lab> createState() => _notes_labState();
}

class _notes_labState extends State<notes_lab> {
  String? result;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          backgroundColor: defaultColor,
          title: Text("Results")),
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
                              labelText: "Result",
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 16.0,
                                  horizontal:
                                  10), // Adjust the vertical padding as needed
                              hintText: 'Enter patient note', // Placeholder text
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
                              result = value;
                            },
                          ))
                    ],
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        try {
                          print(widget.id);
                          print(result);
                          apiviewpatients.confirmpatient(widget.id, result!);
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
