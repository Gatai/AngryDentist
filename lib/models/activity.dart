import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';

class Activity {
  final String
      sortKey; // Sträng i stil med 202007101500 för att kunna sortera lättare
  final DateTime created; // datum när dokumentet skapades
  final String userId; //användarens Id
  final bool teethBrushed;
  final bool fluorine;
  final bool floss;
  DateTime dateTime;

  Activity({
    this.created,
    this.userId,
    this.sortKey,
    this.floss,
    this.fluorine,
    this.teethBrushed,
    this.dateTime,
  });

  Activity.fromDocument(DocumentSnapshot snapshot)
      : created = snapshot.data['created'],
        userId = snapshot.data['userId'],
        sortKey = snapshot.data['sortKey'],
        fluorine = snapshot.data['fluorine'],
        floss = snapshot.data['floss'],
        teethBrushed = snapshot.data['teethBrushed'],
        dateTime = snapshot.data['dateTime'];

  Activity.fromData(DataSnapshot snapshot)
      : created = snapshot.value['created'],
        userId = snapshot.value['userId'],
        sortKey = snapshot.value['sortKey'],
        fluorine = snapshot.value['fluorine'],
        floss = snapshot.value['floss'],
        teethBrushed = snapshot.value['teethBrushed'],
        dateTime = snapshot.value['dateTime'];

  Map<String, dynamic> toJson() {
    return {
      'created': created,
      'userId': userId,
      'sortKey': sortKey,
      'fluorine': fluorine,
      'teethBrushed': teethBrushed,
      'floss': floss,
      'dateTime': dateTime,
    };
  }
}
