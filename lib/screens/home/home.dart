import 'package:AngryDentist/models/activity.dart';
import 'package:AngryDentist/scaleUI/size_config.dart';
import 'package:AngryDentist/services/auth.dart';
import 'package:AngryDentist/sideBar/sideBarWidget.dart';
import 'package:AngryDentist/widgets/dateTimeWidget.dart';
import 'package:AngryDentist/widgets/helloWidget.dart';
import 'package:AngryDentist/widgets/buttonsWidget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//Måste alltid vara med
void main() => runApp(Home());
final title = 'Angry Dentist';

// Inloggad user, vid instansiering av classen kommer detta att vara null
var currentUser;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var dateTime = DateTime.now();

   dynamic refresh(dateTime) {
    setState(() {
      this.dateTime = dateTime;
      print('dateTimeee');
      print(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    //Effectively scale UI according to different screen sizes
    SizeConfig().init(context);

    //Om det finns en inloggad user kommer variabeln att få informationen
    currentUser = Provider.of<Activity>(context);
    // marcus tandtroll ID: m4n1afnoP1hK2ST1d5KCfC6xAez2
    final AuthService _auth = AuthService();
    var paddingAbove = EdgeInsets.fromLTRB(17, 17, 17, 17);
    var paddingBelow = EdgeInsets.fromLTRB(10, 10, 10, 10);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light().copyWith(scaffoldBackgroundColor: Colors.white),
      home: Scaffold(
        drawer: SideBarWidget(),
        appBar: AppBar(
          title: Text(
            title,
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),
          backgroundColor: Colors.teal,
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
              HelloWidget(dateTime: dateTime),
              DateTimeWidget(dateTime: dateTime, notifyParent: refresh),
              Padding(
                padding: paddingAbove,
              ),
              Text(
                "Morning",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: paddingBelow,
              ),
              ButtonsWidget(isMorning: true, dateTime: dateTime),
              Padding(
                padding: paddingAbove,
              ),
              Text(
                "Night",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: paddingBelow,
              ),
              ButtonsWidget(isMorning: false, dateTime: dateTime,)
            ]),
      ),
    );
  }
}
