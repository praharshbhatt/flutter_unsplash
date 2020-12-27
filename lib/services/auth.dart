import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_unsplash/models/user_profile.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'firestore.dart';

//User object
UserProfile userProfile;

///Auth Service
class AuthService {
  // constructor
  AuthService() {
    checkIsSignedIn().then((_blIsSignedIn) async {
      //Get the profile data from the database
      if (_blIsSignedIn) await FirestoreService.getUserData();
    });
  }

  //Checks if the user has signed in
  Future<bool> checkIsSignedIn() async {
    bool blIsSignedIn = false;
    GoogleSignIn googleSignIn = GoogleSignIn();
    if (FirebaseAuth.instance != null && (await googleSignIn.isSignedIn())) {
      User firebaseUser = FirebaseAuth.instance.currentUser;

      if (firebaseUser != null) {
        //User is already logged in
        blIsSignedIn = true;
      } else {
        blIsSignedIn = false;
      }
    } else {
      blIsSignedIn = false;
    }
    return blIsSignedIn;
  }

  //Log in using google
  Future<dynamic> googleSignIn() async {
    // Step 1
    GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

    // Step 2
    GoogleSignInAuthentication googleAuth = await googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    UserCredential _res = await FirebaseAuth.instance.signInWithCredential(credential);
    User firebaseUser = _res.user;

    //Add the data to the database
    userProfile = UserProfile.fromFirebaseUser(firebaseUser);
    await FirestoreService.getUserData();
    if (userProfile.uid == null || userProfile.email == null) {
      userProfile = UserProfile.fromFirebaseUser(firebaseUser);
      await FirestoreService.setUserData();
    }

    //Get the data from the database
    FirestoreService.getUserData();

    return firebaseUser;
  }

  void signOut() => FirebaseAuth.instance.signOut();
}
