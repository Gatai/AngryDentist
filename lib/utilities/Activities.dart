import 'package:AngryDentist/models/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// class för att hantera Activities
class Activities {
  DateFormat dateFormat = DateFormat("yyyyMMdd");
  DateFormat dateYearMonth = DateFormat("yyyyMM");

  //metod för att spara en activity
  saveActivity(String userId, bool morning, bool teethBrushed, bool fluorine, bool floss, DateTime dateTime) {

    if(dateTime == null){
      dateTime = DateTime.now();
    } 

    var activity = Activity(
        created: DateTime.now(), // Lägger till tid och datum
        userId: userId,  //lägger in user ID
        sortKey: dateFormat.format(DateTime.now()) + (morning ? "M" : "N"), // Denna är bara en sträng av dagens datum, det är alltid lättare att sortera mot en sträng :) ej nödvändig, ta bort den om du inte använder det
        teethBrushed: teethBrushed,
        fluorine: fluorine,
        floss: floss,
        dateTime: dateTime,
        );

    Firestore.instance
        .collection('activities')
        .document(userId)
        .collection(dateYearMonth.format(DateTime.now()))
        .document(activity.sortKey) // <-- skapar ett dokument med Id som i sortKey
        .setData(activity.toJson());

        //Ifall du ska spara i exempelvis Users/m4n1afnoP1hK2ST1d5KCfC6xAez2/Activities måste du ändra i collectionanropet till
        //.collection('users').document(userId).collection("Activities") så att den hittar i strukturen
  }

  getActivity(String userId, DateTime dateTime){
    
  }

}
