import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:intl/intl.dart';
import 'package:time_slot/controller/day_part_controller.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

import '../../Animationss/animationLogo.dart';
import '../../styles/colors.dart';
import '../api_doctor/api.dart';
import '../api_doctor/doctor2.dart';
import 'Confirm.dart';
class dateAndhour extends StatefulWidget {
  const dateAndhour(this.id, {super.key});
  @override
  State<dateAndhour> createState() => _dateAndhourState();
  // final List<DateTime> dayss;
  final int id;
}

class _dateAndhourState extends State<dateAndhour> {
  DateTime initialDisplayDate =
      DateTime.now(); // initialDisplayDate for the date picker

  List<DateTime> dates = [
    // mwa3ed el doctor el avaiable bs wel ba2y msh 3ayzeno
    DateTime(
      2023,
      4,
      1,
    ),
    DateTime(
      2023,
      4,
      2,
    ),
    DateTime(
      2023,
      4,
      3,
    ),
    DateTime(
      2023,
      4,
      4,
    ),
    DateTime(
      2023,
      4,
      5,
    ),
    DateTime(
      2023,
      1,
      6,
    )
  ];
  DateTime selectedTime = DateTime.now(); // selected time from the time slot
  DateTime pickedDate = DateTime.now(); // picked date from the date picker
  DateTime bookedDate = DateTime.now(); //  picked date + selected time

  DayPartController dayPartController = DayPartController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: defaultColor,

          title: Text("Choose Date And Time"),
        ),
        body: FutureBuilder<Doctor2?>(
          future: Api.getDoctorProfileByID(widget.id),
          builder: (BuildContext context, AsyncSnapshot<Doctor2?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child:  LogoAnimation(),);
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final doctor = snapshot.data;
              return Container(
                color: Colors.grey.shade100,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Center(
                          child: Text("Choose the date"),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70),
                          padding: EdgeInsets.all(8),
                          child: SfDateRangePicker(
                            initialDisplayDate: initialDisplayDate,
                            showActionButtons: true,

                            selectableDayPredicate: (DateTime val) =>
                                doctor!.appoinments.contains(
                                        DateTime(val.year, val.month, val.day))
                                    ? true
                                    : false,

                            // val.day==4 || val.weekday == 6|| val.weekday == 5 ? true : false,
                            // showTodayButton: true,
                            showNavigationArrow: true,
                            todayHighlightColor: defaultColor,
                            allowViewNavigation: true,
                            onSubmit: (value) {
                              pickedDate = value as DateTime;
                              print(pickedDate); // testing bardo
                            },
                          ),
                        ),
                        Divider(),
                        Center(
                          child: Text("Choose time "),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white70),
                          padding: EdgeInsets.all(8),
                          child: TimesSlotGridViewFromInterval(
                            locale: "en",
                            // icon: Icons.access_time,
                            initTime: selectedTime,
                            crossAxisCount: 4,
                            unSelectedColor: Colors.green.shade300,
                            timeSlotInterval: TimeSlotInterval(
                              start: TimeOfDay(
                                  hour: doctor!.timeFrom as int, minute: 00),
                              end: TimeOfDay(
                                  hour: (doctor.timeTo as int) + 1, minute: 00),
                              interval: Duration(
                                  hours: 0, minutes: doctor.duration as int),
                            ),
                            onChange: (value) {
                              setState(() {
                                selectedTime = value;
                                bookedDate = DateTime(
                                    pickedDate.year,
                                    pickedDate.month,
                                    pickedDate.day,
                                    selectedTime.hour,
                                    selectedTime.minute);
                              });

                              print(selectedTime); // for testing
                              print(bookedDate); // for testing

                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return confirm(widget.id,bookedDate);
                              }));
                            },
                          ),
                        ),
                        Divider(),
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Center(child: Text('No data found'));
            }
          },
        ));
  }
}
