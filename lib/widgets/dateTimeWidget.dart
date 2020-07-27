import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState();
}
  DateFormat dateFormat = DateFormat("yyyy-MM-dd");
  var dateTime = dateFormat.format(DateTime.now());

class _DateTimeWidgetState extends State<DateTimeWidget> {

  @override
  Widget build(BuildContext context) {
    return Text(
      dateTime,
      style: new TextStyle(
          fontSize: 30.0,
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: "Roboto"),
    );
  }
}