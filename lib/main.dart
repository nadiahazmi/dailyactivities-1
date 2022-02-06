import 'dart:async';
import 'package:dailyactivities/views/authenticate/login.dart';
import 'package:dailyactivities/views/home.dart';
import 'package:flutter/material.dart';
import 'activity_models/activity_api.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  //const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Activities',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Open-Sans'),
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            ' Daily Activities Generator',
          ),
        ),
        body: LoginS(),
      ),
    );
  }
}
