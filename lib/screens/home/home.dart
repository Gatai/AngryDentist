import 'package:AngryDentist/models/user.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:AngryDentist/widgets/helloWidget.dart';
import 'package:AngryDentist/widgets/buttonsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Måste alltid vara med
void main() => runApp(Home());
final title = 'Angry Dentist Home Page';

// Inloggad user, vid instansiering av classen kommer detta att vara null
var currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    //Om det finns en inloggad user kommer variabeln att få informationen

    currentUser = Provider.of<User>(context);
    // marcus tandtroll ID: m4n1afnoP1hK2ST1d5KCfC6xAez2
    final AuthService _auth = AuthService();

    return MaterialApp(
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.blueAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: new Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[HelloWidget(), Text("Morning"), ButtonsWidget(), Text("Night"), ButtonsWidget()]),
      ),
    );
  }
}

