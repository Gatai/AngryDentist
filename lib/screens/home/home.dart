import 'package:AngryDentist/models/user.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:AngryDentist/utilities/activities.dart';
import 'package:AngryDentist/utilities/users.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Måste alltid vara med
void main() => runApp(Home());
final title = 'Angry Dentist Home Page';

// Inloggad user, vid instansiering av classen kommer detta att vara null
var currentUser;

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //Om det finns en inloggad user kommer variabeln att få informationen
    
    currentUser = Provider.of<User>(context);
    // marcus tandtroll ID: m4n1afnoP1hK2ST1d5KCfC6xAez2
    final AuthService _auth = AuthService();

    print("Print ------------------------------------------------- ");
    print(  new Users().getUserName(currentUser.uid));

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
            children: <Widget>[
              new Text(
                "Hello (username)",
              //  new Users().getUserName(currentUser.uid),
                style: new TextStyle(
                    fontSize: 20.0,
                    color: const Color(0xFF000000),
                    fontWeight: FontWeight.w200,
                    fontFamily: "Roboto"),
              ),
              Buttons()
            ]),
      ),
    );
  }
}

class Buttons extends StatefulWidget {
  @override
  _ButtonsState createState() => _ButtonsState();
}

class _ButtonsState extends State<Buttons> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              print('Tryckte på flour');
              //Anropar metod i classen Activities för att spara information (behövs inte en egen class för det, men koden blir snyggare så)
              new Activities().saveActivity("Flour", currentUser.uid);
            },
            child: Text(
              'Flour',
              style: new TextStyle(fontSize: 12.0),
            ),
            color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              print('Tryckte på tandtråd');
              new Activities().saveActivity("Tandtråd", currentUser.userId);
            },
            child: Text(
              'Tandtråd',
              style: new TextStyle(fontSize: 12.0),
            ),
            color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,
          ),
          RaisedButton(
            onPressed: () {
              print('Tryckte på borsta tänderna');
              new Activities().saveActivity("Borstat tänderna", currentUser.userId);
            },
            child: Text(
              'Borsta tänderna',
              style: new TextStyle(fontSize: 12.0),
            ),
            color: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,
          ),
        ],
      ),
    );
  }
}
