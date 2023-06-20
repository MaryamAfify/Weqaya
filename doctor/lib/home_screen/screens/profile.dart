import 'package:doctor/home_screen/screens/profile_screens/about_us.dart';
import 'package:doctor/home_screen/screens/profile_screens/contact_us.dart';
import 'package:doctor/home_screen/screens/profile_screens/get_patient_data/get_api.dart';
import 'package:doctor/home_screen/screens/profile_screens/personal_information.dart';
import 'package:flutter/material.dart';

import '../../logout/logout.dart';
import '../../styles/colors.dart';

class My_Profile extends StatefulWidget {
  const My_Profile({Key? key}) : super(key: key);

  @override
  State<My_Profile> createState() => _My_ProfileState();
}

class _My_ProfileState extends State<My_Profile> {
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
  late Future<Album> futureAlbum;
  @override
  void initState() {
    super.initState();
    futureAlbum = api.getPost();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: defaultColor,
        title: Text("My Profile") ,),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 20, 0, 0),
              width: 200,
              height: 200,
              child: FutureBuilder<Album>(
                future: futureAlbum,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        CircleAvatar(
                          radius: 40.0,
                          backgroundImage: NetworkImage('https://cdn-icons-png.flaticon.com/512/8247/8247509.png'),
                        ),
                        SizedBox(height: 10,),
                        ListTile(
                          title: Center(child: Text(snapshot.data!.name)),
                        )
                      ],
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),

            SizedBox(height: 14,),
           Container(
             width: 360,

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
                       leading: Text(" Update Personal Information",style: TextStyle(
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
                             return personal_information();}
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
                     leading: Text("Contact Us ",style: TextStyle(
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
                       leading: Text("About Us",style: TextStyle(
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
    );
  }
}
