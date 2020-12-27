import 'package:firebase_auth/firebase_auth.dart';

import '../utils/utility.dart';
import 'package:flutter/material.dart';
import 'package:flutter_unsplash/services/auth.dart';

import 'main_page.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: EdgeInsets.all(12),
          children: [
            //Title
            Padding(
              padding: const EdgeInsets.all(12),
              child: Text(
                "Don't have an account yet?",
                style: Theme.of(context).textTheme.headline4,
                textAlign: TextAlign.start,
              ),
            ),

            //Sub title
            Padding(
              padding: const EdgeInsets.all(24),
              child: Text(
                "Login with Google\n\nThis helps us to save your preferences and make this app sync across devices",
                style: Theme.of(context).textTheme.headline5,
                textAlign: TextAlign.start,
              ),
            ),

            SizedBox(height: 50),

            //Google Login button
            Padding(
              padding: const EdgeInsets.all(12),
              child: RaisedButton(
                child: Row(
                  children: [
                    Image.network(
                      "https://www.freepnglogos.com/uploads/google-logo-png/google-logo-icon-png-transparent-background-osteopathy-16.png",
                      height: 50,
                      width: 50,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Text(
                        "Login with Google",
                        style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                onPressed: () {
                  //LOGIN USING GOOGLE HERE
                  Utility.showLoading(context);

                  AuthService authService = new AuthService();
                  var user = authService.googleSignIn();

                  //Pop the loading
                  Navigator.of(context).pop(false);

                  //Check if the login was successful
                  if (user == null) {
                    //Login failed
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        // return object of type Dialog
                        return AlertDialog(
                          title: Text("Failed to log in!"),
                          content: Text(
                              "Please make sure your Google Account is usable. Also make sure that you have a active internet connection, and try again."),
                          actions: <Widget>[
                            // usually buttons at the bottom of the dialog
                            new FlatButton(
                              child: new Text("Close"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  } else {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainPage()));
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
