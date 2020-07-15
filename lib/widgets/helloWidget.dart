import 'package:AngryDentist/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HelloWidget extends StatefulWidget {
  @override
  _HelloWidget createState() => _HelloWidget();
}

class _HelloWidget extends State<HelloWidget> {
  static String message;

  @override
  Widget build(BuildContext context) {
    var currentUser = Provider.of<User>(context);

    if (message == null) {
      //Set default value
      message = "Hello";

      //Fetch data from database
      Firestore.instance
          .collection("users")
          .where("uid", isEqualTo: currentUser.uid)
          .getDocuments()
          .then((value) {
        //Triggers after database reply
        value.documents.forEach((result) {
          print("got " + result.data["name"]);
          //Trigger widget update
          setState(() {
            message = "Hello ${result.data["name"]}";
          });
        });
      });
    }

    //Return result
    return Text(
      message,
      style: new TextStyle(
          fontSize: 20.0,
          color: const Color(0xFF000000),
          fontWeight: FontWeight.w200,
          fontFamily: "Roboto"),
    );
  }
}
