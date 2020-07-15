import 'package:AngryDentist/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class för att hantera User
class Users {
  static Firestore _database = Firestore.instance;

  //metod för att hämta en användare
  static Future<User> getUser(String userUid) async {
    return await getUserData(userUid);
  }

  static Future<User> getUserData(String userUid) async {
    print("print apa");
    var user = new User();
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
