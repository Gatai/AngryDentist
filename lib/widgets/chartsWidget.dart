import 'package:AngryDentist/models/activityData.dart';
import 'package:AngryDentist/screens/home/home.dart';
import 'package:AngryDentist/widgets/dateTimeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_utils/date_utils.dart';

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
    return Stack(children: <Widget>[
      _buildText(),
      charts.BarChart(
        seriesList,
        barGroupingType: charts.BarGroupingType.grouped,
        behaviors: [
          new charts.ChartTitle('',
              //subTitle: 'Top sub-title text',
              behaviorPosition: charts.BehaviorPosition.top,
              titleStyleSpec: charts.TextStyleSpec(fontSize: 00),
              titleOutsideJustification:
                  charts.OutsideJustification.middleDrawArea,
              // Set a larger inner padding than the default (10) to avoid
              // rendering the text too close to the top measure axis tick label.
              // The top tick label may extend upwards into the top margin region
              // if it is located at the top of the draw area.
              innerPadding: 120),
           new charts.PercentInjector(
             totalType: charts.PercentInjectorTotalType.domain),
        ],
       primaryMeasureAxis: new charts.PercentAxisSpec(),
      ),
    ]);
    // used to display precient in y-axis
    // Configures a [PercentInjector] behavior that will calculate measure
    // values as the percentage of the total of all data in its series.
    // behaviors: [
    //   new charts.PercentInjector(
    //       totalType: charts.PercentInjectorTotalType.series)
    // ],
    // // Configure the axis spec to show percentage values.
    // primaryMeasureAxis: new charts.PercentAxisSpec(),
  }

  Widget _buildText() {
    return Container(
      color: Colors.redAccent,
      padding: EdgeInsets.all(30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            month,
            style: new TextStyle(
                decoration: TextDecoration.none,
                fontSize: 50.0,
                color: Colors.white,
                fontWeight: FontWeight.w200,
                fontFamily: "Roboto"),
          ),
        ],
      ),
    );
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

        var days = Utils.daysInMonth(dateTime).length;

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
            ),
            new charts.Series<ActivityData, String>(
              id: 'fluorine',
              domainFn: (ActivityData activity, _) => activity.yearMonth,
              measureFn: (ActivityData activity, _) => activity.amount,
              data: fluorineData,
              colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
              // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
            ),
            new charts.Series<ActivityData, String>(
              id: 'floss',
              domainFn: (ActivityData activity, _) => activity.yearMonth,
              measureFn: (ActivityData activity, _) => activity.amount,
              data: flossData,
              colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
              // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
            ),
          ];
        });
      });
    });
  }
}
