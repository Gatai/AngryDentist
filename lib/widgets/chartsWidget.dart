import 'package:AngryDentist/models/activity.dart';
import 'package:AngryDentist/screens/home/home.dart';
import 'package:AngryDentist/widgets/dateTimeWidget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
/// Bar chart example
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:intl/intl.dart';

class GroupedBarChart extends StatelessWidget {
  final List<charts.Series> seriesList;
  final dateTime;

  GroupedBarChart({this.seriesList, this.dateTime} );

  factory GroupedBarChart.withSampleData() {
    return new GroupedBarChart(
      _createSampleData(),
      dateTime: DateTime.now(),
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
 List<charts.Series<ActivityData, String>> _createSampleData() {


  DateFormat dateYearMonth = DateFormat("yyyyMM");

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

    final teethBrushedData = [
      new ActivityData('TeethBrushed', 5),
      new ActivityData('Fluorine', 25),

    ];
    final fluorineData = [
      new ActivityData('Fluorine', 25),
      new ActivityData('TeethBrushed', 5),
      new ActivityData('Floss', 10),

    ];
    final flossData = [
      new ActivityData('Floss', 10),

    ];

    return [
      new charts.Series<ActivityData, String>(
        id: 'Desktop',
        domainFn: (ActivityData activity, _) => activity.yearMonth,
        measureFn: (ActivityData activity, _) => activity.amount,
        data: teethBrushedData,
        colorFn: (_, __) => charts.MaterialPalette.blue.shadeDefault,
        fillColorFn: (_, __) =>
            charts.MaterialPalette.blue.shadeDefault.lighter,
      ),
      new charts.Series<ActivityData, String>(
        id: 'Tablet',
        domainFn: (ActivityData activity, _) => activity.year,
        measureFn: (ActivityData activity, _) => activity.sales,
        data: fluorineData,
        colorFn: (_, __) => charts.MaterialPalette.green.shadeDefault,
        // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
      ),
      new charts.Series<ActivityData, String>(
        id: 'Mobile',
        domainFn: (ActivityData activity, _) => activity.year,
        measureFn: (ActivityData activity, _) => activity.sales,
        data: flossData,
        colorFn: (_, __) => charts.MaterialPalette.purple.shadeDefault,
        // fillColorFn: (_, __) => charts.MaterialPalette.transparent,
      ),
    ];
  }
}

/// Sample ordinal data type.
class ActivityData {
  final String yearMonth;
  final int amount;
  OrdinalSales(this.yearMonth, this.amount);
}
