import 'package:AngryDentist/models/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventWidget extends StatefulWidget {
  @override
  _EventWidgetState createState() => _EventWidgetState();
}

class _EventWidgetState extends State<EventWidget> {

  var isMorning = false;
  var hasFetched = "";

  DateFormat dateFormat = DateFormat("yyyyMMdd");
  DateFormat dateYearMonth = DateFormat("yyyyMM");

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<Activity>(context);
    getData(currentUser);

    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
        Text(" test data"),
        //Hämta här värden från databasen
      ]),
    );
  }

  void getData(Activity currentUser) {
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
          print("I got " + value.data["sortKey"]);

        }
      });
    }
  }
}
