import 'package:AngryDentist/models/activity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// class för att hantera User
class Users {
  static Firestore _database = Firestore.instance;

  //metod för att hämta en användare
  static Future<Activity> getUser(String userUid) async {
    return await getUserData(userUid);
  }

  static Future<Activity> getUserData(String userUid) async {
    print("print apa");
    var user = new Activity();
    _database
        .collection("activities")
        .where("userId", isEqualTo: userUid)
        .getDocuments()
        .then((value) {
      value.documents.forEach((result) {
        print("print 1");
        print("print 2");
        print(result.data["name"]);

       // user = Activity.fromDocument(result);
      });
    });
    return user;
  }
}
