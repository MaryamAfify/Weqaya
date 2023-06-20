import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:time_slot/model/time_slot_Interval.dart';
import 'package:time_slot/time_slot_from_interval.dart';

import '../Animationss/animationLogo.dart';
import '../doctor/api_doctor/api.dart';
import '../doctor/api_doctor/doctor.dart';
class myAppoinments extends StatefulWidget {
  const myAppoinments({super.key});

  @override
  State<myAppoinments> createState() => _myAppoinmentsState();
}

class _myAppoinmentsState extends State<myAppoinments> {
  late Future<Doctor> futureDoctor;
  late Future<List<DateTime>> _futureDates;
  DateTime selectedTime = DateTime.now();
   DateTime initialDisplayDate =
      DateTime.now();

  void initState() {
    super.initState();
    futureDoctor = Api.getDoctorProfile();
     _futureDates = Api.getDates();
    
    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: defaultColor,
          title: Text("My Appoinments"),
        ),
        body: Container(
          color: Colors.grey.shade100,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                  mainAxisSize: MainAxisSize.min,
                children: [
                  FutureBuilder<List<DateTime>>(
                    future: Api.getDates(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                          child: LogoAnimation(),
                        );
                      } else if (snapshot.hasError) {
                        return Text('Error fetching data from API 1');
                      } else if (snapshot.hasData) {
                         List<DateTime> dates = snapshot.data!;
                        // Use the fetched data in your widgets
                        return Column(
                          
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
                        dates.contains(DateTime(val.year, val.month, val.day))
                            ? true
                            : false,

                    // val.day==4 || val.weekday == 6|| val.weekday == 5 ? true : false,
                    // showTodayButton: true,
                    showNavigationArrow: true,
                    todayHighlightColor: Colors.blue,
                    allowViewNavigation: true,
                    onSubmit: (value) {
                       // testing bardo
                    },
                  ),
                ),

                          ],
                        );
                      } else {
                        return Text('No data available from API 1');
                      }
                    },
                  ),
                  FutureBuilder<Doctor>(
                    future: Api.getDoctorProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator();
                      } else if (snapshot.hasError) {
                        return Text('Error fetching data from API 1');
                      } else if (snapshot.hasData) {
                        final doctor = snapshot.data!;
                        // Use the fetched data in your widgets
                        return Column(
                          children: [
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
                                      hour: doctor.timeFrom as int, minute: 00),
                                  end: TimeOfDay(
                                      hour: (doctor.timeTo as int)+1 , minute: 00),
                                  interval: Duration(hours:0, minutes:  doctor.duration as int),
                                ),
                                onChange: (value) {},
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      } else {
                        return Text('Error at doctor data function');
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
