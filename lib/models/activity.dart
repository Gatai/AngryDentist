import 'package:firebase_database/firebase_database.dart';

class Activity {
  final String
      sortKey; // Sträng i stil med 202007101500 för att kunna sortera lättare
  final DateTime created; // datum när dokumentet skapades
  final String userId; //användarens Id
  // Skapa Variabel för att skilja på förmiddag och eftermiddag
  final bool teehBrushed;
  final bool fluorine;
  final bool floss;  

  Activity({
    this.created,
    this.userId,
    this.sortKey,
    this.floss,
    this.fluorine,
    this.teehBrushed,
  });

  Activity.fromData(DataSnapshot snapshot)
        :created = snapshot.value['created'],
        userId = snapshot.value['userId'],
        sortKey = snapshot.value['sortKey'],
        fluorine = snapshot.value['fluorine'],
        floss = snapshot.value['floss'],
        teehBrushed = snapshot.value['teehBrushed'];

  Map<String, dynamic> toJson() {
    return {
      'created': created,
      'userId': userId,
      'sortKey': sortKey,
      'fluorine': fluorine,
      'teehBrushed': teehBrushed,
      'floss': floss,
    };
  }
}
