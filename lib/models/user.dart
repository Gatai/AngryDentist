import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String userId;
  final String name;
  final String email;

  User({this.userId, this.name, this.email});

  User.fromData(DataSnapshot snapshot)
      : userId = snapshot.value['userId'],
        name = snapshot.value['name'],
        email = snapshot.value['email'];

  User.fromDocument(DocumentSnapshot snapshot)
      : userId = snapshot.data['userId'],
        name = snapshot.data['name'],
        email = snapshot.data['email'];

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
    };
  }
}
