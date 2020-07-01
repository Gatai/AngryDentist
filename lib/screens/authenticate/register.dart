import 'package:AngryDentist/services/auth.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  final AuthService _auth =AuthService();

  //text field state
  String name = '';
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        elevation: 0.0,
        title: Text('Sign up to angry dentist'),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: <Widget>[
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                    hintText: 'Name',
                    icon: new Icon(
                      Icons.mood,
                      color: Colors.grey,
                    )),
                onChanged: (val){
                  setState(() => name = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                    hintText: 'Email',
                    icon: new Icon(
                      Icons.mail,
                      color: Colors.grey,
                    )),
                onChanged: (val){
                  setState(() => email = val);
                }
              ),
              SizedBox(height: 20.0),
              TextFormField(
                decoration: new InputDecoration(
                    hintText: 'Password',
                    icon: new Icon(
                    Icons.lock,
                    color: Colors.grey,
                  )),
                obscureText: true,
                onChanged: (val){
                  setState(() => password = val);
                }
              ),
              SizedBox(height: 20.0),
              RaisedButton(
                color: Colors.red[300],
                child: Text(
                  'Register',
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
                  print(email);
                  print(password);
                }
              )
            ],
          ),
        ),
      )
    );
  }
}