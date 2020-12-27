import 'package:firebase_auth/firebase_auth.dart';

///A model class for the user profile to store in [FirebaseFirestore]
class UserProfile {
  String uid, email;
  Map<String, List<String>> collections = new Map();

  UserProfile.fromMap(Map mapUser) {
    if (mapUser == null) return;

    //Load user's info
    if (mapUser.containsKey("uid")) uid = mapUser["uid"];
    if (mapUser.containsKey("email")) email = mapUser["email"];

    //Load user's collections
    if (mapUser.containsKey("collections")) {
      Map col = mapUser["collections"];
      col.forEach((key, value) {
        List<String> lstCol = new List();
        value.forEach((val) => lstCol.add(val));
        collections[key] = lstCol;
      });
    }
  }

  UserProfile.fromFirebaseUser(User firebaseUser) {
    uid = firebaseUser.uid;
    email = firebaseUser.email;
  }

  toMap() {
    Map<String, dynamic> mapUser = {
      "uid": uid,
      "email": email,
    };

    //Load user's collections
    collections.forEach((key, value) {
      collections[key] = value.toSet().toList();
    });
    if (collections != null && mapUser.isNotEmpty) mapUser["collections"] = collections;

    return mapUser;
  }
}
