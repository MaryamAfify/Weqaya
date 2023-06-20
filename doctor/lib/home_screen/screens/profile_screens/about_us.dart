import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../styles/colors.dart';

class about_us extends StatelessWidget {
  const about_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: Size(375, 667));

    return Scaffold(
      appBar: AppBar(
        title: Text("About Us"),
        centerTitle: true,
        backgroundColor: defaultColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(ScreenUtil().setWidth(16)),
          child: Column(
            children: [
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Introduction:",style: TextStyle(fontSize: 18),)),
              Text(
                'Mobile applications have revolutionized various aspects of'
                    ' our lives, and the healthcare industry is no exception.'
                    ' This paper aims to explore the objectives of a medical'
                    ' mobile application that focuses on test analysis,'
                    ' cost-effective lab recommendations, and doctor referrals based on patient information. '
                    'The application allows users to access their test results,'
                    ' locate nearby laboratories, choose medical specialties,'
                    ' and receive personalized recommendations from healthcare professionals.',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),
              SizedBox(height:5,),
              Text(
                'Objective 1: Efficient Test Analysis and Recommendations'
              'One of the primary goals of the mobile application is'
             ' to provide efficient test analysis for patients.'
              'By integrating patient information and medical data,'
                 ' the application processes and interprets test results promptly.'
              'The app employs advanced algorithms to identify any abnormal'
              'findings and highlights them for further analysis.'
            'By offering comprehensive insights into the test results'
                  'patients can gain a better understanding of their health status',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),
              SizedBox(height:5,),
              Text(
                'Objective 2: Cost-Effective Lab Recommendations'
                  'Another key objective of the mobile application is to recommend '
                    'cost-effective laboratories for test procedures. By utilizing a database '
                    'of registered labs, the app compares prices and '
                    'services provided by different facilities. It'
                  'prioritizes cost-effectiveness without compromising'
              'the quality of testing. This feature enables patients'
              'to make informed decisions about where to conduct their tests,'
                     'considering their budget and location.',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                'Objective 3: Easy Access to Test Locations and Specialties'
                'The application aims to provide users with easy access to'
                    ' information about nearby laboratories. '
                    'Through the app user-friendly interface'
                'patients can search for labs based on their location and view detailed profiles of each facility. Additionally, the app allows users to filter their search results based on medical specialties, ensuring that patients '
                'can find laboratories that cater to their specific testing requirements',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),
              SizedBox(height: 5,),
              Text(
                'Objective 4: Doctor Referrals and Specialist Recommendations'
                  'To enhance the user experience, '
                'the mobile application facilitates doctor'
              'referrals and specialist recommendations. '
              'After analyzing the test results, the app suggests suitable medical'
              'specialists based on the identified health conditions.'
                'By integrating a comprehensive database of healthcare professionals,'
                'patients can access detailed information about doctors,'
                'including their specialties, qualifications, and patient reviews.'
              'This feature empowers users to make informed decisions'
                  'when selecting a doctor for further consultation and treatment.',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),
              SizedBox(height: 5,),
              Container(
                  alignment: Alignment.centerLeft,
                  child: Text("Conclusion:",style: TextStyle(fontSize: 18),)),
                 SizedBox(height: 5,),
              Text(
                'In conclusion, the objectives of a medical mobile application focusing on test analysis, cost-effective lab recommendations, and doctor referrals aim to improve healthcare accessibility and patient engagement. By providing efficient test analysis, cost-effective lab recommendations, easy access to test locations, and doctor referrals, the application empowers patients to take control of their health journey. Such mobile applications play a crucial role in enhancing healthcare services by leveraging technology to bridge the gap between patients and healthcare providers.',
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(13),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

