import 'package:doctor/home_screen/screens/profile_screens/about_us.dart';
import 'package:doctor/home_screen/screens/profile_screens/contact_us.dart';
import 'package:flutter/material.dart';
import '../../DoctorForm/doctorForm_update.dart';
import '../../DoctorView/myProfile.dart';
import '../../DoctorView/navigationBarDoctor.dart';
import '../../logout/logout.dart';
import '../../styles/colors.dart';
import '../api_doctor/api.dart';
import '../api_doctor/doctor.dart';
class doctor_profile extends StatefulWidget {


  @override
  State<doctor_profile> createState() => _doctor_profileState();
}

class _doctor_profileState extends State<doctor_profile> {
  String _image = "images/image.jpg";

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
        backgroundColor: defaultColor,
        centerTitle: true,
        title:
        Text("Doctor Settings"),),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: EdgeInsets.all(15.0),
                child: FutureBuilder<Doctor>(
                  future: Api.getDoctorProfile(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: snapshot.data!.photo != null ? MemoryImage(snapshot.data!.photo!) : null,
                        ),
                        title: Text(snapshot.data!.name),
                        subtitle: Text(snapshot.data!.speciality),
                      );
                    } else if (snapshot.hasError) {
                      return Text(snapshot.error.toString());
                    }
                    return CircularProgressIndicator();
                  },
                ),
              ),
              SizedBox(height: 20,),
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
                          leading: Text("Edit Information",style: TextStyle(
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
                            return doctorForm_update();}),);
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
                          leading: Text("My Patients",style: TextStyle(
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
                                return doctorNavigation();}
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
                              return myProfile();}
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
