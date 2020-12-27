import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/login.dart';
import 'screens/main_page.dart';
import 'services/auth.dart';

Future<void> main() async {
  //initialize firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  //run app
  runApp(FlutterUnsplash());
}

class FlutterUnsplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // set status bar color
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
      statusBarColor: Colors.black12,
    ));

    //Material App
    return MaterialApp(
      title: 'Flutter Unsplash Client',

      //Set the theme
      theme: ThemeData(
        accentColor: Colors.grey[400],
        canvasColor: Colors.transparent,
        scaffoldBackgroundColor: Colors.white,

        //Card Theme
        cardColor: Colors.grey,
        cardTheme: const CardTheme(
          color: Colors.grey,
          elevation: 7,
          margin: EdgeInsets.all(12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),

        //Buttons
        buttonColor: Colors.black87,
        buttonTheme: ButtonThemeData(
          focusColor: Colors.black87,
          hoverColor: Colors.black87,
          buttonColor: Colors.black87,
          disabledColor: Colors.black87,
          highlightColor: Colors.black87,
          splashColor: Colors.black,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          minWidth: 100,
          height: 50,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            elevation: MaterialStateProperty.all<double>(10),
            shape: MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(borderRadius: BorderRadius.circular(5))),
          ),
        ),
      ),

      //Hide the debug banner
      debugShowCheckedModeBanner: false,

      //Homepage
      home: FutureBuilder<bool>(
        future: checkIfSignedIn(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (snapshot.hasData == false) return SplashScreen();

          return snapshot.data
              // User is logged in, open the app
              ? MainPage()
              // User is not logged in, open registration
              : LoginScreen();
        },
      ),
    );
  }
}

Future<bool> checkIfSignedIn() async {
  AuthService authService = AuthService();
  return await authService.checkIsSignedIn();
}

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(30),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FlutterLogo(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "Flutter Unsplash Client\nBy Praharsh Bhatt",
                  style: TextStyle(fontFamily: "Poppins", fontSize: MediaQuery.of(context).size.width * 0.05, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
