import 'package:AngryDentist/screens/home/home.dart';
import 'package:AngryDentist/widgets/buttonsWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class TableCalendarWidget extends StatefulWidget {
  final dateTime;
  final month;

  TableCalendarWidget({this.dateTime, this.month});

  @override
  _TableCalendarWidgetState createState() =>
      _TableCalendarWidgetState(dateTime: dateTime);
}

class _TableCalendarWidgetState extends State<TableCalendarWidget> {
  CalendarController _calendarController;
  static DateTime dateTime;
  Map<DateTime, List> _events;

  var month;
  var hasFetched;

  var textStyle = new TextStyle(fontSize: 18.0);
  var paddingAbove = EdgeInsets.all(5.0);
  var paddingBelow = EdgeInsets.all(5.0);

  _TableCalendarWidgetState({dateTime});

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
    _events = {
      // DateTime.now(): ['test', 'test2']
    };
    refreshMarker();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //   refreshMarker();
    print("bild");
    return new WillPopScope(
      onWillPop: () async {
        print("back button");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => Home(),
          ),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text('Flutter Calendar'),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              //Bygger kalendern
              _buildTableCalendar(),
              Padding(
                padding: paddingAbove,
              ),
              Text(
                "Morning",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: paddingBelow,
              ),
              ButtonsWidget(isMorning: true, dateTime: dateTime),
              Text(
                "Night",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
              Padding(
                padding: paddingBelow,
              ),
              ButtonsWidget(isMorning: false, dateTime: dateTime),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTableCalendar() {
    return TableCalendar(
      events: _events,
      initialCalendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
          canEventMarkersOverflow: true,
          todayColor: Colors.orange,
          selectedColor: Colors.teal,
          markersColor: Colors.greenAccent[700],
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white)),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(20.0),
        ),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      onDaySelected: (date, events) {
        setState(() {
          dateTime = date;
        });
      },
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, events) => Container(
            //Hur stor marginal med cirken
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.teal, borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
        todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.orange,
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
      ),
      calendarController: _calendarController,
    );
  }

  void getDataMonth(DateTime dateTime) {
    DateFormat dateYearMonth = DateFormat("yyyyMM");

    // Hämta aktivicy från DB
    //Fetch data from database
    Firestore.instance
        .collection("activities")
        .document(currentUser.userId)
        .collection(dateYearMonth.format(dateTime))
        .getDocuments()
        .then((value) {
      setState(() {
        value.documents.forEach((n) {
          if (n.data["dateTime"] != null) {
            _events.putIfAbsent(
                n.data["dateTime"].toDate(), () => ["Lägg till fler händelse"]);
          }
        });
      });
    });
  }

  void refreshMarker() {
    DateFormat dateYearMonth = DateFormat("yyyyMM");

    var tempMonth = dateYearMonth.format(dateTime);

    if (hasFetched != tempMonth) {
      getDataMonth(dateTime == null ? DateTime.now() : dateTime);
      getDataMonth(dateTime == null
          ? DateTime.now()
          : DateTime(dateTime.year, dateTime.month - 1));
      getDataMonth(dateTime == null
          ? DateTime.now()
          : DateTime(dateTime.year, dateTime.month + 1));
    }
  }
}
