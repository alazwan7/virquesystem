import 'package:flutter/material.dart';

import 'package:virque/test.dart';

import 'home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VirQue Login',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple
      ),
        home: WelcomePage(),

    );
  }
}







