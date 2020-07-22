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

  //use constructor to choose if the buttons should be day or night buttons

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<Activity>(context);
    // Fetch from database using current date + "m" / "n" as key
    // evaluate button colors depending on activity booleans

    if (message == null) {
      //Set default value
      message = "Hello";

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
            message = "Hello ${value.data["name"]}";
          });
      });
    }

    //Return result
    return Text(
      message,
      style: new TextStyle(
          fontSize: 50.0,
          color:  Colors.white,
          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
    );
  }
}
