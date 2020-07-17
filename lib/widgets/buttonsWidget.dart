import 'package:AngryDentist/models/user.dart';
import 'package:AngryDentist/utilities/activities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ButtonsWidget extends StatefulWidget {
  final bool isMorning;

  ButtonsWidget({this.isMorning});

  @override
  _ButtonsWidgetState createState() =>
      _ButtonsWidgetState(isMorning: isMorning);
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  var pressAttentionFluorine = false;
  var pressAttentionTeehBrushed = false;
  var pressAttentionFloss = false;
  var isMorning = false;
  DateFormat dateFormat = DateFormat("yyyyMMdd");

  _ButtonsWidgetState({this.isMorning});

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<User>(context);

    // Hämta aktivicy från DB
    //Fetch data from database
    Firestore.instance
        .collection("Activities")
        .where("uid", isEqualTo: currentUser.uid)
        .where("sortKey",
            isEqualTo:
                dateFormat.format(DateTime.now()) + (isMorning ? "M" : "N"))
        .getDocuments()
        .then((value) {
      //Triggers after database reply
      value.documents.forEach((result) {
         print("got " + result.data["sortKey"]);
        //Trigger widget update
        setState(() {
          pressAttentionFluorine = result.data["fluorine"];
        });
      });
    });
    
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            color: pressAttentionFluorine ? Colors.green : Colors.redAccent,

            child: Text(
              'Fluorine',
              style: new TextStyle(fontSize: 12.0),
            ),
            //   color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,

            onPressed: () {
              print('Tryckte på fluorine');
              //Anropar metod i classen Activities för att spara information (behövs inte en egen class för det, men koden blir snyggare så)

              setState(() => pressAttentionFluorine = !pressAttentionFluorine);

              new Activities().saveActivity(
                  currentUser.uid,
                  isMorning,
                  pressAttentionTeehBrushed,
                  pressAttentionFluorine,
                  pressAttentionFloss);
            },
          ),
          RaisedButton(
            color: pressAttentionFloss ? Colors.green : Colors.redAccent,

            child: Text(
              'Floss',
              style: new TextStyle(fontSize: 12.0),
            ),
            //color: Colors.redAccent,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,

            onPressed: () {
              print('Tryckte på floss');

              setState(() => pressAttentionFloss = !pressAttentionFloss);

              new Activities().saveActivity(
                  currentUser.uid,
                  isMorning,
                  pressAttentionTeehBrushed,
                  pressAttentionFluorine,
                  pressAttentionFloss);
            },
          ),
          RaisedButton(
            color: pressAttentionTeehBrushed ? Colors.green : Colors.redAccent,

            child: Text(
              'TeehBrushed',
              style: new TextStyle(fontSize: 12.0),
            ),
            //  color: Colors.red,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.yellowAccent,

            onPressed: () {
              print('Tryckte på teehBrushed');

              setState(
                  () => pressAttentionTeehBrushed = !pressAttentionTeehBrushed);

              new Activities().saveActivity(
                  currentUser.uid,
                  isMorning,
                  pressAttentionTeehBrushed,
                  pressAttentionFluorine,
                  pressAttentionFloss);
            },
          ),
        ],
      ),
    );
  }
}
