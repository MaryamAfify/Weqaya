import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../../../styles/colors.dart';

class appSetting extends StatefulWidget {
  const appSetting({super.key});

  @override
  State<appSetting> createState() => _appSettingState();
}

class _appSettingState extends State<appSetting> {
  bool val = true;
   bool val1 = false;
    bool val2 = false;
     bool val3 = false;
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Settings"),
        centerTitle: true,
        backgroundColor: defaultColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Email",style: TextStyle(fontWeight: FontWeight.bold),),
                  new Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('Change'),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: TextStyle(height: 1.5),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    hintStyle: TextStyle(fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Password",style: TextStyle(fontWeight: FontWeight.bold)),
                  new Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('Change'),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  
                  style: TextStyle(height: 1.5),
                  obscureText: true,
                  keyboardType: TextInputType.visiblePassword,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    hintStyle: TextStyle(fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text("Language",style: TextStyle(fontWeight: FontWeight.bold)),
                  new Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: Text('Change'),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                child: TextField(
                  style: TextStyle(height: 1.5),
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'language',
                    hintStyle: TextStyle(fontSize: 12),
                    enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(width: 3, color: Colors.grey.shade200)),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Colors.blueAccent),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Notifications",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  Text("Check up"),
                  new Spacer(),
                  Switch(
                    value: val,
                    onChanged: (newVal) {
                      setState(() {
                        val = newVal;
                      });
                    },
                    activeColor: Colors.green,
                    
                  ),
                ],
              ),
              Row( children: [
                  Text("Offers"),
                  new Spacer(),
                  Switch(
                    value: val1,
                    onChanged: (newval) {
                     
                    },
                    activeColor: Colors.green,
                    
                  ),
                ],),
              Row( children: [
                  Text("Appoinment reminder"),
                  new Spacer(),
                  Switch(
                    value: val2,
                    onChanged: (newval) {
                      
                    },
                    activeColor: Colors.green,
                    
                  ),
                ],),
              Row( children: [
                  Text("Daily information"),
                  new Spacer(),
                  Switch(
                    value: val3,
                    onChanged: (newval) {
                      
                    },
                    activeColor: Colors.green,
                    
                  ),
                ],),
            ],
          ),
        ),
      ),
    );
  }
}
