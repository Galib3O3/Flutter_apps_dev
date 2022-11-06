
import 'package:app/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding();
  await Firebase.initializeApp();
  //print(FirebaseAuth.instance.currentUser!);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of my application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Save Community',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: splashS(),
    );
  }
}
