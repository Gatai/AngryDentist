import 'package:AngryDentist/models/user.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:AngryDentist/utilities/Activities.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Måste alltid vara med
void main() => runApp(Home());

// Inloggad user, vid instansiering av classen kommer detta att vara null
var currentUser;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    //Om det finns en inloggad user kommer variabeln att få informationen
    currentUser = Provider.of<User>(context);
    // marcus tandtroll ID: m4n1afnoP1hK2ST1d5KCfC6xAez2

    return MaterialApp(
      theme:
          ThemeData.dark().copyWith(scaffoldBackgroundColor: Colors.blueAccent),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Buttons(), // <-- skapar din widget
        ),
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    var title = 'Angry Dentist Home Page';

    return Scaffold(
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
      body: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              onPressed: () {
                print('Tryckte på flour');
                //Anropar metod i classen Activities för att spara information (behövs inte en egen class för det, men koden blir snyggare så)
                //Du får fylla i för resten av aktivitererna
                new Activities().saveActivity("Flour", currentUser.uid);
              },
              child: Text('Flour'),
              color: Colors.redAccent,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.yellowAccent,
            ),
            RaisedButton(
              onPressed: () {
                print('Tryckte på tandtråd');
              },
              child: Text('Tandtråd'),
              color: Colors.redAccent,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.yellowAccent,
            ),
            RaisedButton(
              onPressed: () {
                print('Tryckte på borsta tänderna');
              },
              child: Text('Borsta tänderna'),
              color: Colors.red,
              textColor: Colors.white,
              padding: EdgeInsets.all(10.0),
              splashColor: Colors.yellowAccent,
            ),
          ],
        ),
      ),
    );
  }
}
