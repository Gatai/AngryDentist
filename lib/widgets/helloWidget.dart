import 'package:AngryDentist/models/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelloWidget extends StatefulWidget {
  @override
  _HelloWidget createState() => _HelloWidget();
}

class _HelloWidget extends State<HelloWidget> {
  static String message;
  static String userId;


  @override
  Widget build(BuildContext context) {
    // Fetch from database using current date + "m" / "n" as key
    // evaluate button colors depending on activity booleans

    setupMessage();

    //Return result
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,

        children: <Widget>[
          Text(
            greeting(),
            style: new TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
          ),
           Text(
             message,
            style: new TextStyle(
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
          ),
        ],
      ),
    );
  }

  void setupMessage() {
    var currentUser = Provider.of<Activity>(context);

    if (message == null || userId != currentUser.userId) {
      //Set default value
      message = greeting();
      //Fetch data from database
      Firestore.instance
          .collection("activities")
          .document(currentUser.userId)
          .get()
          .then((value) {
        //Triggers after database reply
        print("got " + value.data["name"]);
        //Trigger widget update
        setState(() {
          message = " ${value.data["name"]}";
          userId = currentUser.userId;
        });
      });
    }
  }

  String greeting() {
    var hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Morning';
    }
    if (hour < 17) {
      return 'Afternoon';
    }
    return 'Evening';
  }
}
