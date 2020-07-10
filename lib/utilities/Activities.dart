import 'package:AngryDentist/models/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

// class för att hantera Activities
class Activities {
  DateFormat dateFormat = DateFormat("yyyyMMddHHmmss");

  //metod för att spara en activity
  saveActivity(String name, String userId) {
    var activity = Activity(
        created: DateTime.now(), // Lägger till tid och datum
        name: name, //lägger in namn på activityn
        userId: userId, //lägger in user ID
        sortKey: dateFormat.format(DateTime.now()) // Denna är bara en sträng av dagens datum, det är alltid lättare att sortera mot en sträng :) ej nödvändig, ta bort den om du inte använder det
        );
    Firestore.instance
        .collection('Activities')
        .document()
        .setData(activity.toJson());

        //Ifall du ska spara i exempelvis Users/m4n1afnoP1hK2ST1d5KCfC6xAez2/Activities måste du ändra i collectionanropet till
        //.collection('users').document(userId).collection("Activities") så att den hittar i strukturen
  }
}
