import 'package:AngryDentist/models/activity.dart';
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
  var pressAttentionTeethBrushed = false;
  var pressAttentionFloss = false;
  var isMorning = false;
  var hasFetched = "";

  DateFormat dateFormat = DateFormat("yyyyMMdd");
  DateFormat dateYearMonth = DateFormat("yyyyMM");

  _ButtonsWidgetState({this.isMorning});

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<Activity>(context);

    initButtons(currentUser);

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
                  currentUser.userId,
                  isMorning,
                  pressAttentionTeethBrushed,
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
                  currentUser.userId,
                  isMorning,
                  pressAttentionTeethBrushed,
                  pressAttentionFluorine,
                  pressAttentionFloss);
            },
          ),
          RaisedButton(
            color: pressAttentionTeethBrushed ? Colors.green : Colors.redAccent,

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

              setState(() =>
                  pressAttentionTeethBrushed = !pressAttentionTeethBrushed);

              new Activities().saveActivity(
                  currentUser.userId,
                  isMorning,
                  pressAttentionTeethBrushed,
                  pressAttentionFluorine,
                  pressAttentionFloss);
            },
          ),
        ],
      ),
    );
  }

  void initButtons(Activity currentUser) {
    if (hasFetched != currentUser.userId) {
      // Hämta aktivicy från DB
      //Fetch data from database
      Firestore.instance
          .collection("activities")
          .document(currentUser.userId)
          .collection(dateYearMonth.format(DateTime.now()))
          .document(dateFormat.format(DateTime.now()) + (isMorning ? "M" : "N"))
          .get()
          .then((value) {
        //Triggers after database reply
        if (value.data != null) {
          print("I got " +
              value.data["sortKey"] +
              (isMorning ? "Morning" : "Night"));
          //Trigger widget update
          if (this.mounted) {
            setState(() {
              pressAttentionFluorine = value.data["fluorine"];
              pressAttentionTeethBrushed = value.data["teethBrushed"];
              pressAttentionFloss = value.data["floss"];
              hasFetched = currentUser.userId;
            });
          }
        }
      });
    }
  }
}
