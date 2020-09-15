import 'package:AngryDentist/scaleUI/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}

DateFormat dateFormat = DateFormat("MMMMd");
var dateTime = dateFormat.format(DateTime.now());

class _DateTimeWidgetState extends State<DateTimeWidget> {
  @override
  Widget build(BuildContext context) {
    //Effectively scale UI according to different screen sizes
    SizeConfig().init(context);

    return Container(
      height: SizeConfig.blockSizeVertical * 7,
      width: SizeConfig.blockSizeHorizontal * 100,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GestureDetector(
              onTap: () {
                setState(() {
                  // getMonth(1);
                });
              },
              child: Container(
                  padding: const EdgeInsets.all(8),
                  child: IconButton(
                      icon: new Icon(Icons.arrow_back), onPressed: null))),
          Text(
            dateTime,
            style: new TextStyle(
                fontSize: 30.0,
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontFamily: "Roboto"),
          ),
           GestureDetector(
              onTap: () {
                setState(() {
                  // getMonth(-1);
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
}
