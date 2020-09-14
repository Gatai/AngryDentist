import 'package:AngryDentist/models/activity.dart';
import 'package:AngryDentist/scaleUI/size_config.dart';
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

  var currentMonth;


  @override
  Widget build(BuildContext context) {
    //Effectively scale UI according to different screen sizes
    SizeConfig().init(context);

    //title
    setupMessage();

    //Return result
    return Container(
      height: SizeConfig.blockSizeVertical * 10,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
           GestureDetector(
              onTap: () {
                setState(() {
                //  getMonth(-1);
                });
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      icon: new Icon(Icons.arrow_back), onPressed: null))),
          Text(
            greeting(),
            style: new TextStyle(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
          ),
          Text(
            //Name
            message,
            style: new TextStyle(
                fontSize: 35.0,
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
          ),
             GestureDetector(
              onTap: () {
                setState(() {
                 // getMonth(1);
                });
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      icon: new Icon(Icons.arrow_forward), onPressed: null))),
        ],
      ),
    );
  }

//get the current user name
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
