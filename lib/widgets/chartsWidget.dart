import 'package:AngryDentist/models/activityData.dart';
import 'package:AngryDentist/screens/home/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class ChartsWidget extends StatefulWidget {
  final List<charts.Series> seriesList;
  final dateTime;
  ChartsWidget({this.dateTime, this.seriesList});

  @override
  _ChartsWidgetState createState() => _ChartsWidgetState();
}

/*
factory ChartsWidget.getData(DateTime dateTime) {
    return new ChartsWidget(
      _createSampleData(dateTime), dateTime
    );
  }
*/

class _ChartsWidgetState extends State<ChartsWidget> {
  List<charts.Series> seriesList;

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }
}

List<charts.Series<ActivityData, String>> _createSampleData(DateTime dateTime) {
 // var stats = List<charts.Series<ActivityData, String>>();

  DateFormat dateYearMonth = DateFormat("yyyyMM");

  int teethBrushedMorning = 0;
  int teethBrushedNight = 0;

  Firestore.instance
      .collection("activities")
      .document(currentUser.userId)
      .collection(dateYearMonth.format(dateTime))
      .getDocuments()
      .then((value) {
    //Keep track of month fetched to avoid multiple reads of same month
    value.documents.forEach((n) {
      print(teethBrushedNight);
      print("test");
      print(teethBrushedMorning);

      if (n.data != null) {
        if (n.documentID.endsWith("M")) {
          if (n.data["teethBrushed"] == true) {
            teethBrushedMorning++;
          }
        } else if (n.documentID.endsWith("N")) {
          if (n.data["teethBrushed"] == true) {
            teethBrushedNight++;
          }
        }
      }

      final teethBrushedData = [
        new ActivityData('Morning', teethBrushedMorning),
        new ActivityData('Night', teethBrushedNight),
      ];
      final fluorineData = [
        new ActivityData('Morning', 5),
        new ActivityData('Night', 25),
      ];
      final flossData = [
        new ActivityData('Morning', 5),
        new ActivityData('Night', 25),
      ];

      return [
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
}

/*
class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final dateTime;

  @override
  GroupedBarChart(this.seriesList, this.dateTime);

  factory GroupedBarChart.getData(DateTime dateTime) {
    return new GroupedBarChart(
      _createSampleData(dateTime), dateTime
    );
  }

  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<ActivityData, String>> _createSampleData( DateTime dateTime) {
    var stats = List<charts.Series<ActivityData, String>>();

    DateFormat dateYearMonth = DateFormat("yyyyMM");

    int teethBrushedMorning = 0;
    int teethBrushedNight = 0;

    Firestore.instance
        .collection("activities")
        .document(currentUser.userId)
        .collection(dateYearMonth.format(dateTime))
        .getDocuments()
        .then((value) {
      //Keep track of month fetched to avoid multiple reads of same month
      value.documents.forEach((n) {
        
        
        print(teethBrushedNight);
        print("test" );
        print(teethBrushedMorning);


        if (n.data != null) {
          if (n.documentID.endsWith("M")) {
            if (n.data["teethBrushed"] == true) {
              teethBrushedMorning++;
            }
          } else if (n.documentID.endsWith("N")) {
            if (n.data["teethBrushed"] == true) {
              teethBrushedNight++;
            }
          }
        }

        final teethBrushedData = [
          new ActivityData('Morning', teethBrushedMorning),
          new ActivityData('Night', teethBrushedNight),
        ];
        final fluorineData = [
          new ActivityData('Morning', 5),
          new ActivityData('Night', 25),
        ];
        final flossData = [
          new ActivityData('Morning', 5),
          new ActivityData('Night', 25),
        ];

        return [
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
  }
}
*/

/*
Exempel kod
/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final bool animate;

  GroupedBarChart(this.seriesList, {this.animate});

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      // Disable animations for image tests.
      animate: false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return new charts.BarChart(
      seriesList,
      animate: animate,
      barGroupingType: charts.BarGroupingType.grouped,
    );
  }

  /// Create series list with multiple series
  static List<charts.Series<OrdinalSales, String>> _createSampleData() {
    final desktopSalesData = [
      new OrdinalSales('2014', 5),
      new OrdinalSales('2015', 25),
      new OrdinalSales('2016', 100),
      new OrdinalSales('2017', 75),
    ];

    final tableSalesData = [
      new OrdinalSales('2014', 25),
      new OrdinalSales('2015', 50),
      new OrdinalSales('2016', 10),
      new OrdinalSales('2017', 20),
    ];

    final mobileSalesData = [
      new OrdinalSales('2014', 10),
      new OrdinalSales('2015', 15),
      new OrdinalSales('2016', 50),
      new OrdinalSales('2017', 45),
    ];

    return [
      new charts.Series<OrdinalSales, String>(
        id: 'Desktop',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: desktopSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Tablet',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: tableSalesData,
      ),
      new charts.Series<OrdinalSales, String>(
        id: 'Mobile',
        domainFn: (OrdinalSales sales, _) => sales.year,
        measureFn: (OrdinalSales sales, _) => sales.sales,
        data: mobileSalesData,
      ),
    ];
  }
}

/// Sample ordinal data type.
class OrdinalSales {
  final String year;
  final int sales;

  OrdinalSales(this.year, this.sales);
}
*/
