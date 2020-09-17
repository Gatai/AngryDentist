import 'package:AngryDentist/scaleUI/size_config.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  //constructor for widget (SignIn)
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  var title = 'Sign in to angry dentist';

  //text field state
  String error = '';
  String email = '';
  String password = '';

  //Style
  TextStyle style = TextStyle(fontFamily: 'Montserrat', fontSize: 20.0);
  BorderRadius borderCircular = BorderRadius.circular(18.0);

  @override
  Widget build(BuildContext context) {
    //Effectively scale UI according to different screen sizes
    SizeConfig().init(context);

    var emailFormField = TextFormField(
        validator: (val) => val.isEmpty ? 'Enter an email' : null,
        style: style,
        decoration: new InputDecoration(
            contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            hintText: 'Email',
            /*  icon: new Icon(
              Icons.mail,
              color: Colors.grey,
            ),*/
            border: OutlineInputBorder(borderRadius: borderCircular)),
        onChanged: (val) {
          setState(() => email = val);
        });

    var passwordFormField = TextFormField(
        validator: (val) => val.length < 6 ? 'Enter a password 6+ chars long' : null,
        decoration: new InputDecoration(
          contentPadding: new EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
          border: OutlineInputBorder(borderRadius: borderCircular),
          hintText: 'Password',
          /*icon: new Icon(
              Icons.lock,
              color: Colors.grey,
            )*/
        ),
        obscureText: true,
        onChanged: (val) {
          setState(() => password = val);
        });
        
    var registerButton = FlatButton.icon(
      icon: Icon(Icons.person_add),
      label: Text('Create account'),
      onPressed: () {
        widget.toggleView();
      },
    );

    return Scaffold(
        backgroundColor: Colors.white,
      /*  appBar: AppBar(
          backgroundColor: Colors.teal,
          elevation: 0.0,
          title: Text(
            title,
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),

          //centerTitle: true,
          //actions: <Widget>[registerButton],
        ),*/

        body: Container(
          height: SizeConfig.blockSizeVertical * 100,
          width: SizeConfig.blockSizeHorizontal * 100,
          //padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                //   mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 230.0,
                    width: 219.0,
                    child: Image.asset(
                      "assets/dog2.png",
                      fit: BoxFit.contain,
                    ),
                  ),
                  Text("Bild och text"),
                  SizedBox(height: 20.0),
                  emailFormField,
                  SizedBox(height: 10.0),
                  passwordFormField,
                  //Space
                  SizedBox(height: 20.0),
                  signInButton(),
                  registerButton,
                  //Lägg till glömt löenord.
                  Text("Lägg till glömt lösenord"),
                  Text(
                    error,
                    style: TextStyle(color: Colors.red, fontSize: 14.0),
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  ButtonTheme signInButton() {
    return ButtonTheme(
      minWidth: SizeConfig.blockSizeVertical * 50,
      height: SizeConfig.blockSizeHorizontal * 13,
      child: RaisedButton(
          shape: RoundedRectangleBorder(borderRadius: borderCircular),
          color: Colors.teal,
          child: Text(
            'Log in',
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            if (_formKey.currentState.validate()) {
              try {
                dynamic result = await _auth.signInWithEmailAndPassword(email, password);

                if (result == null) {
                  setState(() {
                    error = 'Could not sign in with those credentials';
                  });
                } else {}
              } catch (e) {
                setState(() {
                  error = 'Could not sign in with those credentials';
                });
              }
            }
          }),
    );
  }
}
