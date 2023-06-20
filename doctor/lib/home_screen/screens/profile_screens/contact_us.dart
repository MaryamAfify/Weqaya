import 'package:doctor/styles/colors.dart';
import 'package:flutter/material.dart';
class contact_us extends StatelessWidget {
  const contact_us({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Contact us "),
      centerTitle: true,
      backgroundColor: defaultColor,
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 30,),
            Text("Is There Any Comlaint ",style: TextStyle(
              fontSize: 20,
              color: Colors.black87
            ),),
            Text("Or Inquiry ?",
            style: TextStyle(
              fontSize: 20,
              color: Colors.black87
            ),),
            SizedBox(height: 20,),
            CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage("images/head.png"),
            ),
            SizedBox(height: 20,),
            Container(
              color: Colors.white,
              alignment: Alignment.center,
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              child :TextFormField(
                readOnly: true,
                autofocus: false,
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.call),
                  hintText: "Call Us If You Need Any Help",
                    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                    border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.black12,width:5),
                        borderRadius: BorderRadius.all(Radius.circular(10))
                    )
                ),
                //  onChanged: (newname){
                //    newname=snapshot.data!.name;
                //   },
              ),
            ),
            SizedBox(height: 10,),
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black38, width: 1),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 5,),
                    Text("Shams         01114471329")
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 5,),
                    Text("Maryam        01154380881")
                  ],
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Icon(Icons.person),
                    SizedBox(width: 5,),
                    Text("Hady          01062832107")
                  ],
                )
              ],
            ),),

          ],
        ),
      ),
    );
  }
}
