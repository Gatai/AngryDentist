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

  var textStyle = new TextStyle(fontSize: 18.0);
  var textColor = Colors.white;
  var textPadding = EdgeInsets.all(20.0);
  var textSplashColor = Colors.teal;

  _ButtonsWidgetState({this.isMorning});

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<Activity>(context);

    initButtons(currentUser);

    return Container(
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          RaisedButton(
            color: pressAttentionFluorine ? Colors.green : Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              'Fluorine',
              style: textStyle,
            ),
            textColor: textColor,
            padding: textPadding,
            splashColor: textSplashColor,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              'Floss',
              style: textStyle,
            ),
            textColor: textColor,
            padding: textPadding,
            splashColor: textSplashColor,
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
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18.0),
            ),
            child: Text(
              'Teeth Brushed',
              style: textStyle,
            ),
            textColor: textColor,
            padding: textPadding,
            splashColor: textSplashColor,
            onPressed: () {
              print('Tryckte på teeth Brushed');

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
