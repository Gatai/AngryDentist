import 'package:AngryDentist/models/activity.dart';
import 'package:AngryDentist/utilities/activities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class ButtonsWidget extends StatefulWidget {
  final bool isMorning;
  final dateTime;

  ButtonsWidget({this.isMorning, this.dateTime});

  @override
  _ButtonsWidgetState createState() =>
      _ButtonsWidgetState(isMorning: isMorning, dateTime: dateTime);
}

class _ButtonsWidgetState extends State<ButtonsWidget> {
  _ButtonsWidgetState({this.isMorning, this.dateTime});

  var pressAttentionFluorine = false;
  var pressAttentionTeethBrushed = false;
  var pressAttentionFloss = false;
  var isMorning = false;
  var hasFetched;
  var dateTime;

  DateFormat dateFormat = DateFormat("yyyyMMdd");
  DateFormat dateYearMonth = DateFormat("yyyyMM");

  var textStyle = new TextStyle(fontSize: 18.0);
  var textColor = Colors.white;
  var textPadding = EdgeInsets.all(20.0);
  var textSplashColor = Colors.teal;
  var borderRadius = BorderRadius.circular(18.0);

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<Activity>(context);

    dateTime = widget.dateTime;
    if (dateTime == null) {
      dateTime = DateTime.now();
      print("Datum skrivs ut nedan");
      print("n" + dateTime.toIso8601String());
    }

    print("b" + dateTime.toIso8601String());

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
              borderRadius: borderRadius,
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
                  pressAttentionFloss,
                  dateTime);
            },
          ),
          RaisedButton(
            color: pressAttentionFloss ? Colors.green : Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
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
                  pressAttentionFloss,
                  dateTime);
            },
          ),
          RaisedButton(
            color: pressAttentionTeethBrushed ? Colors.green : Colors.redAccent,
            shape: RoundedRectangleBorder(
              borderRadius: borderRadius,
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
                  pressAttentionFloss,
                  dateTime);
            },
          ),
        ],
      ),
    );
  }

  void initButtons(Activity currentUser) {
    var tempDate = dateFormat.format(dateTime);

    if (hasFetched != tempDate) {
      // Hämta aktivicy från DB
      //Fetch data from database
      print("s" + dateTime.toIso8601String());

      Firestore.instance
          .collection("activities")
          .document(currentUser.userId)
          .collection(dateYearMonth.format(dateTime))
          .document(dateFormat.format(dateTime) + (isMorning ? "M" : "N"))
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
              hasFetched = tempDate;
            });
          }
        } else {
          if (this.mounted) {
            setState(() {
              pressAttentionFluorine = false;
              pressAttentionTeethBrushed = false;
              pressAttentionFloss = false;
              hasFetched = tempDate;
            });
          }
        }
      });
    }
  }
}
