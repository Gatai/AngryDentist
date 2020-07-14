import 'package:firebase_database/firebase_database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  final String uid;
  final String name;
  final String email;

  User({this.uid, this.name, this.email});

  User.fromData(DataSnapshot snapshot)
      : uid = snapshot.value['uid'],
        name = snapshot.value['name'],
        email = snapshot.value['email'];

  User.fromDocument(DocumentSnapshot snapshot)
      : uid = snapshot.data['uid'],
        name = snapshot.data['name'],
        email = snapshot.data['email'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
