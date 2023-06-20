import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/colors.dart';
import 'api_forform/senddata.dart';
class recommendation_screen extends StatefulWidget {
  @override
  _recommendation_screenState createState() => new _recommendation_screenState();
//  State<StatefulWidget> createState() {
//    return _LoginPageState();
//  }
}

class _recommendation_screenState extends State<recommendation_screen> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

//  FormType _formType = FormType.login;
  String? email = "";
  String? Name = "";
  String? PhoneNumber ="";
  String? _smoking ;
  String? age ;
  String? _gender ;
  String? _diabetes ;
  String? _pressure ;
  String? _diabetes_relatives ;
  String? _relativeswithheartattacksorhighcolestrol ;
  String? _medicinefordiabetesorpressure ;
  String? height;
  String? weight ;
  void validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();

//      performLogin();
    }
  }

  Widget _buildUserName() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: TextInputType.text,
            //key: formKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),  decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
              hintText: "Name",
              prefixIcon: Icon(Icons.person_add_alt_1),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12,width:5),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )
          ),
            validator: (value) {
              return value!.isEmpty ? 'Name is Required.' : null;
            },
            onSaved: (value) {
              Name= value!;
            },
          ),
        ),
      ],
    );
  }
  Widget _buildUserAge() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 130,
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: TextInputType.text,
            //key: formKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),  decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
              hintText: "Age",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12,width:5),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )
          ),
            validator: (value) {
              return value!.isEmpty ? 'Age is Required.' : null;
            },
            onSaved: (value) {
              age= value! ;
            },
          ),
        ),
      ],
    );
  }
  Widget _buildUserGender() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 190,
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text("  Gender : ", style: TextStyle(color: Colors.black54),),
              DropdownButton(
                  value: _gender,
                  items: [
                    DropdownMenuItem(
                      child: Text("Male"),
                      value: "Male",
                    ),
                    DropdownMenuItem(
                      child: Text("Female"),
                      value: "Female",
                    )
                  ],

                  onChanged: (String? value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
              ),
            ],
          ),
    )
      ],
    );
  }
  Widget _buildUserDiabetes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 190,
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text("  Diabetes : ",
                style: TextStyle(color: Colors.black54),),
              DropdownButton(
                value: _diabetes,
                items: [
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value:"true",
                  ),
                  DropdownMenuItem(
                    child: Text("No"),
                    value: "false",
                  )
                ],

                onChanged: (String? value) {
                  setState(() {
                    _diabetes = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _buildUserPressure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
           width: 190,
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text("  High Pressure : ",
                style: TextStyle(color: Colors.black54),),
              DropdownButton(
                value: _pressure,
                items: [
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value: "true",
                  ),
                  DropdownMenuItem(
                    child: Text("NO"),
                    value: "false",
                  )
                ],

                onChanged: (String? value) {
                  setState(() {
                    _pressure = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _buildUserDiabetesRelatives() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
              width: 250,
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text("  Diabetes Relatives : ",
                style: TextStyle(color: Colors.black54),),
              DropdownButton(
                value: _diabetes_relatives,
                items: [
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value: "true",
                  ),
                  DropdownMenuItem(
                    child: Text("NO"),
                    value: "false",
                  )
                ],

                onChanged: (String? value) {
                  setState(() {
                    _diabetes_relatives = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _buildUserRelativesWithHeartAttacksOrHighColestrol() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
                        width: 1300,


          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text(" Relatives With Heart Attacks Or High Colestrol :",
                style: TextStyle(color: Colors.black54,fontSize: 12),),
              Expanded(
                child: DropdownButton(
                  value: _relativeswithheartattacksorhighcolestrol,
                  items: [
                    DropdownMenuItem(
                      child: Text("Yes"),
                      value: "true",
                    ),
                    DropdownMenuItem(
                      child: Text("NO"),
                      value: "false",
                    )
                  ],
              
                  onChanged: (String? value) {
                    setState(() {
                      _relativeswithheartattacksorhighcolestrol = value!;
                    });
                  },
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _MedicineForDiabetesOrPressure() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(

          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text(" Medicine For Diabetes Or Pressure: ",
                style: TextStyle(color: Colors.black54),),
              DropdownButton(
                value: _medicinefordiabetesorpressure,
                items: [
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value: "true",
                  ),
                  DropdownMenuItem(
                    child: Text("NO"),
                    value: "false",
                  )
                ],

                onChanged: (String? value) {
                  setState(() {
                    _medicinefordiabetesorpressure = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _buildUserSnoking() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
           width: 190,
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: Colors.black38,),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child:Row(
            children: [
              Text("  Smoking : ",
              style: TextStyle(color: Colors.black54),),
              DropdownButton(
                value: _smoking,
                items: [
                  DropdownMenuItem(
                    child: Text("Yes"),
                    value: "true",
                  ),
                  DropdownMenuItem(
                    child: Text("NO"),
                    value: "false",
                  )
                ],

                onChanged: (String? value) {
                  setState(() {
                    _smoking = value!;
                  });
                },
              ),
            ],
          ),
        )
      ],
    );
  }
  Widget _buildUserPhoneNumber() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          //decoration: kBoxDecorationStyle,
          child: TextFormField(
            keyboardType: TextInputType.text,
            //key: formKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                hintText: "Phone Number",
                prefixIcon: Icon(Icons.phone,color: Colors.black54,),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12,width:5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                )
            ),
            validator: (value) {
              return value!.isEmpty ? 'Email is Required.' : null;
            },
            onSaved: (value) {
              PhoneNumber= value!;
            },
          ),
        ),
      ],
    );
  }
  Widget _buildUserHeight() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 190,
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: TextInputType.text,
            //key: formKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),  decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
              hintText: "Height",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12,width:5),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )
          ),
            validator: (value) {
              return value!.isEmpty ? 'Height is Required.' : null;
            },
            onSaved: (value) {
              height= value! ;
            },
          ),
        ),
      ],
    );
  }
  Widget _buildUserWeight () {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          width: 130,
          alignment: Alignment.centerLeft,
          child: TextFormField(
            keyboardType: TextInputType.text,
            //key: formKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),  decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
              hintText: "Weight ",
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12,width:5),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )
          ),
            validator: (value) {
              return value!.isEmpty ? 'Weight is Required.' : null;
            },
            onSaved: (value) {
              weight= value! ;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSignUpBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: Form(
        child: MaterialButton(
          elevation: 5.0,
          onPressed: () {
            validateAndSave();
         APIPatient.UserForm(Name!,PhoneNumber!,_smoking!,age!,_gender!,_diabetes!,_pressure!,_diabetes_relatives!
         ,_relativeswithheartattacksorhighcolestrol!,_medicinefordiabetesorpressure!,height!,weight!,context);
          },
          //        => print('Login Button Pressed'),
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: defaultColor,
          child: Text(
            'Save',
            style: TextStyle(
              color: Colors.white,
              letterSpacing: 1.5,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Fill out this form for your healthcare"),
      backgroundColor: defaultColor,),
      backgroundColor: Colors.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Form(
            key: formKey,
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10.0),
                      _buildUserName(),
                      SizedBox(
                        height: 10.0,
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Row( children :[
                        _buildUserAge(),
                        SizedBox(
                          width: 30.0,
                        ),
                        _buildUserGender()]),
                      SizedBox(
                        height: 10.0,
                      ),
              _buildUserPhoneNumber(),
                      SizedBox(height: 10,),
                      Row( children :[
                        _buildUserHeight(),
                        SizedBox(
                          width: 5.0,
                        ),
                        _buildUserWeight()]),
                      SizedBox(
                        height: 10.0,
                      ),
                      _MedicineForDiabetesOrPressure(),
                      SizedBox(height: 10.0,),
                      Column(children: [
                        _buildUserDiabetes(),
                        SizedBox(height: 20,),
                        _buildUserDiabetesRelatives(),
                      ],),
                       SizedBox(height: 20,),
                      Column(children: [
                        _buildUserPressure(),
                         SizedBox(height: 20,),
                        _buildUserSnoking()]),
                    SizedBox(height: 20,),
                      _buildUserRelativesWithHeartAttacksOrHighColestrol(),
                      SizedBox(height: 10.0,),
                      _buildSignUpBtn(),



                    ],
                  ),

              ),
            )


        ),
      ),
    );
  }
}

