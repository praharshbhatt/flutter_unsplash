import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_unsplash/models/user_profile.dart';
import 'package:flutter_unsplash/services/auth.dart';

class FirestoreService {
  //Gets the userData
  static Future<bool> getUserData() async {
    bool retValue;

    //Get the user profile data
    FirebaseFirestore.instance
        .collection("Users")
        .doc(FirebaseAuth.instance.currentUser.email)
        .snapshots()
        .listen((documentSnapshot) async {
      if (documentSnapshot != null && documentSnapshot.exists) {
        print("Updated user data:\n" + documentSnapshot.data().toString());
        userProfile = UserProfile.fromMap(documentSnapshot.data());

        //Make the return value true
        retValue = true;
      } else {
        //Update user's data if not already updated
        userProfile = UserProfile.fromFirebaseUser(FirebaseAuth.instance.currentUser);
        await FirestoreService.setUserData();
      }
    });

    while (retValue == null) await Future.delayed(Duration(seconds: 1));
    return retValue;
  }

  //Update the data into the database
  static Future setUserData() async {
    //Notifications
    await FirebaseFirestore.instance.collection("Users").doc(FirebaseAuth.instance.currentUser.email).set(userProfile.toMap());
    return;
  }
}
