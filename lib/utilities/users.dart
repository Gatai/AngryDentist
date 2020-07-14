import 'package:AngryDentist/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:intl/intl.dart';

// class för att hantera User
class Users {
  Firestore _database = Firestore.instance;

  //metod för att hämta en användare
  getUserName(String userUid) {

  print("print apa");

    _database
        .collection("users")
        .where("uid", isEqualTo: userUid)
        .getDocuments()
        .then((value) {
      value.documents.forEach((result) {
        
        print("print 1");
        print("print 2");
        print(result.data["name"]);

        return result.data["name"];
      });
    });
    
  }
}
