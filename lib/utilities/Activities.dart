import 'package:AngryDentist/models/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// class för att hantera Activities
class Activities {
  DateFormat dateFormat = DateFormat("yyyyMMdd");
  DateFormat dateYearMonth = DateFormat("yyyyMM");

  //metod för att spara en activity
  saveActivity(String userId, bool morning, bool teethBrushed, bool fluorine,
      bool floss, DateTime dateTime) {
    if (dateTime == null) {
      dateTime = DateTime.now();
      print("n" + dateTime.toIso8601String());
    } else {
      print("i" + dateTime.toIso8601String());
    }
    var activity = Activity(
      created: DateTime.now(), // Lägger till tid och datum
      userId: userId, //lägger in user ID
      sortKey: dateFormat.format(dateTime) +
          (morning
              ? "M"
              : "N"), // Denna är bara en sträng av dagens datum, det är alltid lättare att sortera mot en sträng :) ej nödvändig, ta bort den om du inte använder det
      teethBrushed: teethBrushed,
      fluorine: fluorine,
      floss: floss,
      dateTime: dateTime,
    );

    Firestore.instance
        .collection('activities')
        .document(userId)
        .collection(dateYearMonth.format(dateTime))
        .document(
            activity.sortKey) // <-- skapar ett dokument med Id som i sortKey
        .setData(activity.toJson());

    // Check if activity.teetBrushed==false && activity.floss==false && activity.flourine==false
    // If all of that is true check if the document exists
    //    If true delete document
    // else (not all settings are false)
    // save document

    /*  //example of how to delete document
      Firestore.instance
        .collection('activities')
        .document(userId)
        .collection(dateYearMonth.format(dateTime))
        .document(
            activity.sortKey) // <-- skapar ett dokument med Id som i sortKey
        .delete();
  */
  }

  getActivity(String userId, DateTime dateTime) {}
}
