import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../styles/colors.dart';
import 'api/senddata.dart';
import 'login.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => new _SignUpPageState();
//  State<StatefulWidget> createState() {
//    return _LoginPageState();
//  }
}

class _SignUpPageState extends State<SignUpPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

//  FormType _formType = FormType.login;
  final TextEditingController emailController = TextEditingController();
  String? password = "";
  String? confirmPass = "";
  String? firstName = "";
  String? lastName = "";


 // void validateAndSave() {
 //   final form = formKey.currentState;

 //   if (form!.validate()) {
   //   form.save();

 //   }
//  }
  void validateAndSave() {
    final form = formKey.currentState;
    if (form!.validate()) {
      form.save();
      API.createUser(
        emailController.text,
        password!,
        confirmPass!,
        firstName!,
        lastName!,
        context,
      );
    }
  }
  Widget _buildUserFirstName() {
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
              hintText: "Full Name",
              prefixIcon: Icon(Icons.person_add_alt_1),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black12,width:5),
                  borderRadius: BorderRadius.all(Radius.circular(10))
              )
          ),
            validator: (value) {
              return value!.isEmpty ? 'Username is Required.' : null;
            },
            onSaved: (value) {
              firstName= value!;
            },
          ),
        ),
      ],
    );
  }
  Widget _buildUserEmail() {
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
                hintText: "Email",
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12,width:5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                )
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Email is required.';
              }
              // Regular expression pattern for email validation
              final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
              if (!emailRegex.hasMatch(value)) {
                return 'Invalid email address.';
              }
              return null;
            },
            onSaved: (value) {
              emailController.text= value!;
            },
          ),
        ),
      ],
    );
  }
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            obscureText: !_passwordVisible,
            //key: formPassKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
    decoration: InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
    hintText: "Password",
        suffixIcon: IconButton(
          icon: Icon(
            _passwordVisible ? Icons.visibility : Icons.visibility_off,
          ),
          onPressed: () {
            setState(() {
              _passwordVisible = !_passwordVisible;
            });
          },
        ),
    prefixIcon: Icon(Icons.lock),
    border: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.black12,width:5),
    borderRadius: BorderRadius.all(Radius.circular(10))
    )
    ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Password is required.';
              }
              if (value.length < 6) {
                return 'Password is too short. It should have at least 6 characters.';
              }
              if (!value.contains(RegExp(r'[A-Z]'))) {
                return 'Password should contain at least one uppercase letter.';
              }
              if (!value.contains(RegExp(r'[a-z]'))) {
                return 'Password should contain at least one lowercase letter.';
              }
              if (!value.contains(RegExp(r'[0-9]'))) {
                return 'Password should contain at least one number.';
              }
              return null;
            },
            onSaved: (String? value) {
              password = value!;
            },
//           validator: (val) =>
//           val.length < 6 ? 'Password too short' : null,
//           onSaved: (val) => _password = val,
          ),
        ),
      ],
    );
  }
  Widget _buildPasswordConfirm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            obscureText: !_confirmPasswordVisible,
            //key: formPassKey,
            style: TextStyle(
              color: Colors.black,
              fontFamily: 'OpenSans',
            ),
            decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10,horizontal: 12),
                hintText: "Confirm Password",
                suffixIcon: IconButton(
                  icon: Icon(
                    _confirmPasswordVisible ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _confirmPasswordVisible = !_confirmPasswordVisible;
                    });
                  },
                ),
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black12,width:5),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                )
            ),
            validator: (String? value) {
              if (value!.isEmpty) {
                return 'Password Match is Required.';
              }
              if (value.length < 6) {
                return 'it does not match.';
              }
              return null;
//              return value.isEmpty ? 'Password is Required.' : null;
//        || value.length < 6 ? 'Password too short' : null;
            },
            onSaved: (String? value) {
              confirmPass = value!;
            },
//           validator: (val) =>
//           val.length < 6 ? 'Password too short' : null,
//           onSaved: (val) => _password = val,
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
          },
          //        => print('Login Button Pressed'),
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: defaultColor,
          child: Text(
            'SignUp',
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
    child: Center(
    child: SingleChildScrollView(
    child: Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
    Image.asset("images/logo.png",
    width: 200,
    height: 200,),
                        SizedBox(height: 10.0),
                        _buildUserFirstName(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildUserEmail(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordTF(),
                        SizedBox(
                          height: 10.0,
                        ),
                        _buildPasswordConfirm(),
                        SizedBox(height: 10.0,),
                        _buildSignUpBtn(),
      SizedBox(height: 40.0,),
      Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("already have an account ",
            style: TextStyle(
              color: Colors.black
            ),),
            GestureDetector(
              onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context){
                       return LoginPage();
                 }));
              },
              child: Text(" login",
                style: TextStyle(color: Colors.blueAccent),),

            ),
          ],
        ),
      ),
                      ],
                    ),
                  ),
                ),
              )


        ),
      ),
        );
  }
}

