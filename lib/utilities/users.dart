import 'package:AngryDentist/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class för att hantera User
class Users {
  Firestore _database = Firestore.instance;

  //metod för att hämta en användare
  User getUserName(String userUid) {
    print("print apa");
    var user;
    _database
        .collection("users")
        .where("uid", isEqualTo: userUid)
        .getDocuments()
        .then((value) {
      value.documents.forEach((result) {
        print("print 1");
        print("print 2");
        print(result.data["name"]);

        user = User.fromDocument(result);
      });
    });
    return user;
  }
}
