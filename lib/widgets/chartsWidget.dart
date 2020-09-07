import 'package:AngryDentist/models/activityData.dart';
import 'package:AngryDentist/screens/home/home.dart';
import 'package:AngryDentist/sideBar/sideBarWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:AngryDentist/scaleUI/size_config.dart';

/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

class ChartsWidget extends StatefulWidget {
  final List<charts.Series> seriesList;
  final dateTime;
  ChartsWidget({this.dateTime, this.seriesList});

  @override
  _ChartsWidgetState createState() =>
      _ChartsWidgetState(seriesList: _createEmptyData());

  //Create a empty list to avoid error on startup and draw
  List<charts.Series<ActivityData, String>> _createEmptyData() {
    final data = [
      new ActivityData('', 0),
    ];

    return [
      new charts.Series<ActivityData, String>(
        id: 'emptydata',
        domainFn: (ActivityData activity, _) => activity.yearMonth,
        measureFn: (ActivityData activity, _) => activity.amount,
        data: data,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      )
    ];
  }
}

class _ChartsWidgetState extends State<ChartsWidget> {
  List<charts.Series<ActivityData, String>> seriesList;

  //To show month
  var month = Jiffy().MMMM;

  _ChartsWidgetState({this.seriesList});

  @override
  void initState() {
    super.initState();
    // read data from db
    _getDataFromDb(DateTime.now());
  }

  @override
  Widget build(BuildContext context) {
    //Effectively scale UI according to different screen sizes
    SizeConfig().init(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Statistik",
            style: new TextStyle(
              color: Colors.black54,
            ),
          ),
          leading: new IconButton(
              icon: new Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SideBarWidget()));
              }),
          backgroundColor: Colors.teal,
        ),
        backgroundColor: Colors.white,
        body: Container(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /*
                      padding: const EdgeInsets.only(bottom: 8),
                    ),
                      */
                    monthTextSection(),
                    barChartSection(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //Build the chart bar
  Widget barChartSection() {
    return Container(
      child: Row(children: [
        Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 400.0,
              height: 600.0,
              child: charts.BarChart(
                seriesList,
                barGroupingType: charts.BarGroupingType.grouped,
                behaviors: [
                  new charts.SeriesLegend(
                    // Positions for "start" and "end" will be left and right respectively
                    // for widgets with a build context that has directionality ltr.
                    // For rtl, "start" and "end" will be right and left respectively.
                    // Since this example has directionality of ltr, the legend is
                    // positioned on the right side of the chart.
                    position: charts.BehaviorPosition.top,
                    // For a legend that is positioned on the left or right of the chart,
                    // setting the justification for [endDrawArea] is aligned to the
                    // bottom of the chart draw area.
                    insideJustification: charts.InsideJustification.topStart,
                    // By default, if the position of the chart is on the left or right of
                    // the chart, [horizontalFirst] is set to false. This means that the
                    // legend entries will grow as new rows first instead of a new column.
                    horizontalFirst: false,
                    // By setting this value to 2, the legend entries will grow up to two
                    // rows before adding a new column.
                    desiredMaxRows: 1,
                    // This defines the padding around each legend entry.
                    cellPadding: new EdgeInsets.only(right: 4.0, bottom: 4.0),
                    // Render the legend entry text with custom styles.
                    entryTextStyle: charts.TextStyleSpec(
                        color: charts.Color(r: 127, g: 63, b: 191),
                        fontFamily: 'Georgia',
                        fontSize: 20),
                  )
                ],

                barRendererDecorator: new charts.BarLabelDecorator<String>(),
                domainAxis: new charts.OrdinalAxisSpec(),
                // Configure the axis spec to show percentage values.
                primaryMeasureAxis: new charts.NumericAxisSpec(
                  tickProviderSpec: new charts.StaticNumericTickProviderSpec(
                    <charts.TickSpec<num>>[
                      charts.TickSpec<num>(0),
                      charts.TickSpec<num>(10),
                      charts.TickSpec<num>(20),
                      charts.TickSpec<num>(30),
                      charts.TickSpec<num>(40),
                      charts.TickSpec<num>(50),
                      charts.TickSpec<num>(60),
                      charts.TickSpec<num>(70),
                      charts.TickSpec<num>(80),
                      charts.TickSpec<num>(90),
                      charts.TickSpec<num>(100),
                    ],
                  ),
                ),
              ),
            )
          ],
        ))
      ]),
    );
  }

  Widget monthTextSection() {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            month,
            style: new TextStyle(
                decoration: TextDecoration.none,
                fontSize: 50.0,
                color: Colors.black,
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
          ),
        ],
      ),
    );
  }

  int daysInMonth(DateTime date) {
    var firstDayThisMonth = new DateTime(date.year, date.month, date.day);
    var firstDayNextMonth = new DateTime(firstDayThisMonth.year,
        firstDayThisMonth.month + 1, firstDayThisMonth.day);
    return firstDayNextMonth.difference(firstDayThisMonth).inDays;
  }

  void _getDataFromDb(DateTime dateTime) {
    DateFormat dateYearMonth = DateFormat("yyyyMM");

    //Morning
    int teethBrushedMorning = 0;
    int fluorineMorning = 0;
    int flossMorning = 0;
    //night
    int teethBrushedNight = 0;
    int fluorineNight = 0;
    int flossNight = 0;

    Firestore.instance
        .collection("activities")
        .document(currentUser.userId)
        .collection(dateYearMonth.format(dateTime))
        .getDocuments()
        .then((value) {
      //Forech in the document from database
      value.documents.forEach((n) {
        //Checking for fluorine
        print("id: ${n.documentID}, f: ${n.data["fluorine"]}");

        if (n.data != null) {
          if (n.documentID.endsWith("M")) {
            if (n.data["teethBrushed"] == true) {
              teethBrushedMorning++;
            }
            if (n.data["floss"] == true) {
              flossMorning++;
            }
            if (n.data["fluorine"] == true) {
              fluorineMorning++;
            }
          } else if (n.documentID.endsWith("N")) {
            if (n.data["teethBrushed"] == true) {
              teethBrushedNight++;
            }
            if (n.data["floss"] == true) {
              flossNight++;
            }
            if (n.data["fluorine"] == true) {
              fluorineNight++;
            }
          }
        }
        //Get the days in dateTime
        var days = daysInMonth(dateTime);
        //var days = Utils.daysInMonth(dateTime).length;

        //test for print the data out
        print("--------------------------");
        print(
            "teethBrushedMorning: $teethBrushedMorning amount of times ${((teethBrushedMorning / days) * 100).round()}%");
        print(
            "flossMorning: $flossMorning amount of times ${((flossMorning / days) * 100).round()}%");
        print(
            "fluorineMorning: $fluorineMorning amount of times ${((fluorineMorning / days) * 100).round()}%");

        //night
        print(
            "teethBrushedNight: $teethBrushedNight amount of times ${((teethBrushedNight / days) * 100).round()}%");
        print(
            "flossNight: $flossNight amount of times ${((flossNight / days) * 100).round()}%");
        print(
            "fluorineNight: $fluorineNight amount of times ${((fluorineNight / days) * 100).round()}%");

        // build the chart data
        final teethBrushedData = [
          new ActivityData(
              'Morning', ((teethBrushedMorning / days) * 100).round()),
          new ActivityData('Night', ((teethBrushedNight / days) * 100).round()),
        ];
        final fluorineData = [
          new ActivityData('Morning', ((fluorineMorning / days) * 100).round()),
          new ActivityData('Night', ((fluorineNight / days) * 100).round()),
        ];
        final flossData = [
          new ActivityData('Morning', ((flossMorning / days) * 100).round()),
          new ActivityData('Night', ((flossNight / days) * 100).round()),
        ];

        // after the db calls, set the state to force the chart to repaint
        setState(() {
          this.seriesList = [
            new charts.Series<ActivityData, String>(
                id: 'teethBrushed',
                domainFn: (ActivityData activity, _) => activity.yearMonth,
                measureFn: (ActivityData activity, _) => activity.amount,
                data: teethBrushedData,
                colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
                fillColorFn: (_, __) =>
                    charts.MaterialPalette.blue.shadeDefault.lighter,
                labelAccessorFn: (ActivityData activity, _) =>
                    '${activity.amount.toString()}%'),
            new charts.Series<ActivityData, String>(
                id: 'fluorine',
                domainFn: (ActivityData activity, _) => activity.yearMonth,
                measureFn: (ActivityData activity, _) => activity.amount,
                data: fluorineData,
                colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
                // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
                labelAccessorFn: (ActivityData activity, _) =>
                    '${activity.amount.toString()}%'),
            new charts.Series<ActivityData, String>(
                id: 'floss',
                domainFn: (ActivityData activity, _) => activity.yearMonth,
                measureFn: (ActivityData activity, _) => activity.amount,
                data: flossData,
                colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
                // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
                labelAccessorFn: (ActivityData activity, _) =>
                    '${activity.amount.toString()}%'),
          ];
        });
      });
    });
  }
}
