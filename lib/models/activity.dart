import 'package:firebase_database/firebase_database.dart';

class Activity {
  final String
      sortKey; // Sträng i stil med 202007101500 för att kunna sortera lättare
  final DateTime created; // datum när dokumentet skapades
  final String name; //namn på activityn exempelvis Flour
  final String userId; //användarens Id
  // Skapa Variabel för att skilja på förmiddag och eftermiddag
  /*
  final bool teehBrushed;
  final bool flour;
  final bool floss;  
  */

  Activity({
    this.created,
    this.name,
    this.userId,
    this.sortKey,
    /* lägg till variabeln */
  });

  Activity.fromData(DataSnapshot snapshot)
      : name = snapshot.value['name'],
        created = snapshot.value['created'],
        userId = snapshot.value['userId'],
        sortKey = snapshot.value['sortKey']
  /* lägg till variabeln */;

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'created': created,
      'userId': userId,
      'sortKey': sortKey,
      /* lägg till variabeln */
    };
  }
}
