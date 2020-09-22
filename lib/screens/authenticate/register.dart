import 'package:AngryDentist/models/user.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  //constructor for widget (Register)
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  var title = 'Sign up to angry dentist';

  //text field state
  String name = '';
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    
    var signInflatButton = FlatButton.icon(
      icon: Icon(Icons.person),
      label: Text('Sign in'),
      onPressed: () {
        widget.toggleView();
      },
    );

    var nameTextFormField = TextFormField(
        decoration: new InputDecoration(
            hintText: 'Name',
            icon: new Icon(
              Icons.mood,
              color: Colors.grey,
            )),
        onChanged: (val) {
          setState(() => name = val);
        });

    var emailFormField = TextFormField(
        validator: (val) => val.isEmpty ? 'Enter an email' : null,
        decoration: new InputDecoration(
            hintText: 'Email',
            icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            )),
        onChanged: (val) {
          setState(() => email = val);
        });

    var passwordtextFormField = TextFormField(
        validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
        decoration: new InputDecoration(
            hintText: 'Password',
            icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )),
        obscureText: true,
        onChanged: (val) {
          setState(() => password = val);
        });

    var registerRaisedButton = RaisedButton(
        color: Colors.red[300],
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
        onPressed: () async {
          if (_formKey.currentState.validate()) {
            dynamic result = await _auth.registerWithEmailAndPassword(email, password);

            if (result == null) {
              setState(() => error = 'Try again');
            } else {
              var userX = User(email: email, name: name, userId: result.userId);
              Firestore.instance.collection('activities').document(result.userId).setData(userX.toJson());
            }
          }
        });

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.0,
          title: Text(
            title,
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),
          actions: <Widget>[signInflatButton],
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0),
                nameTextFormField,
                SizedBox(height: 20.0),
                emailFormField,
                SizedBox(height: 20.0),
                passwordtextFormField,
                SizedBox(height: 20.0),
                registerRaisedButton,
                SizedBox(height: 12.0),
                Text(
                  error,
                  style: TextStyle(color: Colors.redAccent, fontSize: 14.0),
                ),
              ],
            ),
          ),
        ));
  }
}
