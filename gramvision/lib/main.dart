import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gramvision/Homepage/HomeScreen.dart';
import 'package:gramvision/Login/Login.dart';
import 'package:gramvision/Login/SignUp.dart';
import 'package:gramvision/Login/Start.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
      routes: <String, WidgetBuilder>{
        "Login": (BuildContext context) => Login(),
        "SignUp": (BuildContext context) => SignUp(),
        "start": (BuildContext context) => Start(),
      },
    );
  }
}
