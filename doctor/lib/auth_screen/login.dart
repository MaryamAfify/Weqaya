import 'package:doctor/auth_screen/registeration.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../styles/colors.dart';
import 'api/logindata.dart';
import 'api/senddata.dart';
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
//  State<StatefulWidget> createState() {
//    return _LoginPageState();
//  }
}

class _LoginPageState extends State<LoginPage> {
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final formKey = new GlobalKey<FormState>();

//  FormType _formType = FormType.login;
  String? email = "";
  String? password = "";
  void validateAndSave() {
    final form = formKey.currentState;

    if (form!.validate()) {
      form.save();

//      performLogin();
    }
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
              return value!.isEmpty ? 'Email is Required.' : null;
            },
            onSaved: (value) {
              email= value!;
            },
          ),
        ),
      ],
    );
  }
  bool _passwordVisible = false;
  Widget _buildPasswordTF() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          alignment: Alignment.centerLeft,
          child: TextFormField(
            obscureText:  !_passwordVisible,
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
                return 'Password is Required.';
              }
              if (value.length < 6) {
                return 'Password too short and should have Characters and uppercaes.';
              }
              return null;
//              return value.isEmpty ? 'Password is Required.' : null;
//        || value.length < 6 ? 'Password too short' : null;
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
  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10.0),
      width: double.infinity,
      child: Form(
        child: MaterialButton(
          elevation: 5.0,
          onPressed: () {
            validateAndSave();
            login(email.toString(), password.toString(),context);

          },
          //        => print('Login Button Pressed'),
          padding: EdgeInsets.all(5.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          color: defaultColor,
          child: Text(
            'LOGIN',
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
                      SizedBox(height: 10.0,),
                      _buildLoginBtn(),
                      const SizedBox(width: 10,
                        height: 20,),
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account yet? "),
                            GestureDetector(
                              onTap: (){
                                Navigator.of(context).push(MaterialPageRoute(builder: (context){
                                  return SignUpPage();
                                }));
                              },
                              child: Text("create account",
                                style: TextStyle(color: Colors.blueAccent),),

                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10,
                        height: 30,),
                      Center(
                        child: GestureDetector(
                          onTap: (){
                            //Navigator.of(context).push(MaterialPageRoute(builder: (context){
                            //  return password();
                            //  }));
                          },
                          child: Text("reset password",
                            style: TextStyle(color: Colors.blueAccent),),
                        ),
                      )

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

