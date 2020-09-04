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

  DateFormat dateYearMonth = DateFormat("yyyyMM");

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

  refresh(DateTime dateTime) {
    setState(() {
      //hasFetched = null;
      //refreshMarker();
      // fetch current month without fetching previous and next month

       //converting dateTime to only date
        var date = DateTime.parse(new DateFormat("yyyy-MM-dd").format(dateTime));
       _events.remove(date);

      getDataMonth(dateTime);
    });
  }

  @override
  Widget build(BuildContext context) {
    refreshMarker();
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
              tableCalendarSection(),
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
              ButtonsWidget(
                  isMorning: true, dateTime: dateTime, notifyParent: refresh(dateTime)),
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
              ButtonsWidget(
                  isMorning: false, dateTime: dateTime, notifyParent: refresh(dateTime)),
            ],
          ),
        ),
      ),
    );
  }
//Build the tabel layout
  Widget tableCalendarSection() {
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
  //  DateFormat dateYearMonth = DateFormat("yyyyMM");

    // Hämta aktivicy från DB
    //Fetch data from database
    Firestore.instance
        .collection("activities")
        .document(currentUser.userId)
        .collection(dateYearMonth.format(dateTime))
        .getDocuments()
        .then((value) {
      var amountOfEvents = _events.length;
      //Keep track of month fetched to avoid multiple reads of same month
      hasFetched = dateYearMonth.format(dateTime);
      value.documents.forEach((n) {
        if (n.data["dateTime"] != null) {
          //converting timestamp to date
          dateTime = n.data["dateTime"].toDate();
          _events.putIfAbsent(
            //save whithout time
          DateTime.parse(new DateFormat("yyyy-MM-dd").format(dateTime)), () => ["Lägg till fler händelse"]);
        }

        //check if amount of events has changed,
        // in that case set the State to refresh the calendar
        if (amountOfEvents != _events.length) {
          setState(() {
            print("Got events");
          });
        }
      });
    });
  }

  void refreshMarker() {
   // DateFormat dateYearMonth = DateFormat("yyyyMM");
    //Make sure dateTime is never null
    dateTime = dateTime == null ? DateTime.now() : dateTime;
    var tempMonth = dateYearMonth.format(dateTime);

    if (hasFetched != tempMonth) {
      getDataMonth(DateTime(dateTime.year, dateTime.month - 1));
      getDataMonth(DateTime(dateTime.year, dateTime.month + 1));
      // Get current month last because that's the one that will be stored in hasFetched
      getDataMonth(dateTime);
    }
  }

}
