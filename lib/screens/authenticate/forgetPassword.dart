import 'package:AngryDentist/scaleUI/size_config.dart';
import 'package:AngryDentist/screens/authenticate/sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgetPassword extends StatefulWidget {
  @override
  _ForgetPasswordState createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  String email = '';
  String error = '';

  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  BorderRadius borderCircular = BorderRadius.circular(18.0);

  @override
  Widget build(BuildContext context) {
    //Effectively scale UI according to different screen sizes
    SizeConfig().init(context);

    var emailFormField = TextFormField(
        validator: (val) => val.isEmpty ? 'Enter an email' : null,
        style: style,
        decoration: new InputDecoration(contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0), hintText: 'Email', border: OutlineInputBorder(borderRadius: borderCircular)),
        onChanged: (val) {
          setState(() => email = val);
        });

    var returnToSignIn = FlatButton(
      child: Text('Return to sign in'),
      onPressed: () {
       Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SignIn()),
        );
      });

        return Scaffold(
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 230.0,
                          width: 219.0,
                          child: Image.asset(
                            "assets/index.jpg",
                            fit: BoxFit.contain,
                          ),
                        ),
                        Text("Welcome to reset your password!"),
                        SizedBox(height: 20.0),
                        emailFormField,
                        //Space
                        SizedBox(height: 20.0),
                        signInButton(),
                        returnToSignIn,
                    Text(
                      error,
                      style: TextStyle(color: Colors.red, fontSize: 14.0),
                    ),
                  ],
                ),
              ))),
    );
  }

  ButtonTheme signInButton() {
    return ButtonTheme(
      minWidth: SizeConfig.blockSizeVertical * 50,
      height: SizeConfig.blockSizeHorizontal * 13,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: borderCircular),
          color: Colors.teal,
          child: Text(
            'Send',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              try {
                FirebaseAuth.instance.sendPasswordResetEmail(email: email).then((value) => print("Check email"));
              } catch (e) {
                setState(() {
                  error = 'Email finns inte';
                });
              }
            }
          }),
    );
  }
}
