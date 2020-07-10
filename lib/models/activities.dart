
import 'package:firebase_database/firebase_database.dart';

class User {
  final String uid;
  final String name;
  final String email;

  User({this.uid, this.name, this.email});

  User.fromData(DataSnapshot snapshot )
      : uid = snapshot.value['uid'],
        name = snapshot.value['name'],
        email = snapshot.value['email'];

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
    };
  }
}
