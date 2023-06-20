
import 'package:doctor/home_screen/screens/profile_screens/about_us.dart';
import 'package:doctor/lab/lab_profile_updates/screens/api_for_update/api_lab_profile.dart';
import 'package:doctor/lab/lab_profile_updates/screens/api_for_update/get_lab_profile_class.dart';
import 'package:doctor/lab/lab_profile_updates/screens/lab_information_update/navigation_between_pending_complete_inlab.dart';
import 'package:doctor/lab/lab_profile_updates/screens/update_lab.dart';
import 'package:doctor/lab/lab_profile_updates/screens/update_tests.dart';
import 'package:flutter/material.dart';

import '../../home_screen/screens/profile_screens/contact_us.dart';
import '../../logout/logout.dart';
import '../../styles/colors.dart';
import '../lab_profile_aspatientfromlab.dart';


class lab_profile_for_updates extends StatefulWidget {
  @override
  State<lab_profile_for_updates> createState() => _lab_profile_for_updatesState();
}

class _lab_profile_for_updatesState extends State<lab_profile_for_updates> {
  String _image = "images/borg.jpg";

  void updateImage(String newimage) {
    setState(() {
      _name = newimage;
    });
  }
  String _name = "shams khaled";

  void updateName(String newname) {
    setState(() {
      _name = newname;
    });
  }
  String _email = "shamskhaled@gmail.com";

  void updateEmail(String newemail) {
    setState(() {
      _email = newemail;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: defaultColor,
        title: Text("Lab Settings") ,),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: FutureBuilder<labprofile>(
                  future: Apilabprofile.getLabProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return  ListTile(
                        leading: CircleAvatar(
                          radius: 40.0,
                          backgroundImage:snapshot.data!.photo != null ? MemoryImage(snapshot.data!.photo!) : null,
                        ),
                        title: Text(snapshot.data!.name),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return const CircularProgressIndicator();
                  },
                ),
              ),

              SizedBox(height :20),
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),

                      child: ListTile(
                        leading: Text("Lab Information",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                         Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return Update_lab();}
                  ),);
                          },),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text(" Update Avaiable Tests",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                             return UpdateTestsForLab();}
                 ),);
                          },),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text(" My Patients",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                           Navigator.of(context).push(MaterialPageRoute(builder: (context){
                             return navigation_in_lab();}
                            ),);
                          },),
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text("See as Patient",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context){
                             return Lab_profile_for_lab_as_patient();}
                             ),);
                          },),
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text("About us ",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return about_us();}
                              ),);
                          },),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text("Contact us ",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                             Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return contact_us();}
                             ),);
                          },),
                      ),
                    ),

                    SizedBox(height: 20,),
                    Container(
                      width: 358,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: profilesColor,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 2.0,
                            spreadRadius: 0.0,
                            offset: Offset(2.0, 2.0), // shadow direction: bottom right
                          )
                        ],
                      ),
                      child: ListTile(
                        leading: Text("Logout",style: TextStyle(
                            color: Colors.black
                        ),),
                        trailing: IconButton(iconSize: 20,
                          icon: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black,
                          ),
                          // the method which is called
                          // when button is pressed
                          onPressed: () {
                            Auth.logout(context);
                          },),
                      ),
                    ),

                  ],
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
