import 'package:AngryDentist/scaleUI/size_config.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimeWidget extends StatefulWidget {
  final dateTime;

  final dynamic Function(DateTime) notifyParent;

  DateTimeWidget({this.dateTime, this.notifyParent});

  @override
  _DateTimeWidgetState createState() => _DateTimeWidgetState(dateTime: dateTime);
}

class _DateTimeWidgetState extends State<DateTimeWidget> {
  _DateTimeWidgetState({this.dateTime});

  DateFormat dateFormat = DateFormat("MMMMd");
  var dateTime;

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
          buildGestureDetector(-1, new Icon(Icons.arrow_back)),
          Text(
            dateFormat.format(dateTime),
            style: new TextStyle(fontSize: 30.0, color: Colors.black, fontWeight: FontWeight.bold, fontFamily: "Roboto"),
          ),
          buildGestureDetector(1, new Icon(Icons.arrow_forward)),
        ],
      ),
    );
  }

  GestureDetector buildGestureDetector(int plus, Icon arrow) {
    return GestureDetector(
      onTap: () {
        //setState(() {
        dateTime = DateTime(dateTime.year, dateTime.month, dateTime.day + plus);
        if (widget.notifyParent != null) {
          widget.notifyParent(dateTime);
        }
        //});
      },
      child: Container(padding: const EdgeInsets.all(8), child: IconButton(icon: arrow, onPressed: null)),
    );
  }
}
