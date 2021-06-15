import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gramvision/Homepage/HomeScreen.dart';
import 'package:gramvision/Login/Start.dart';

void main() async {
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
        "start": (BuildContext context) => Start(),
      },
    );
  }
}