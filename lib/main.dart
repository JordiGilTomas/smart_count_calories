import 'package:flutter/material.dart';
import 'package:smart_count_calories/screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Smart Count Calories',
      theme: ThemeData.dark(
          // primarySwatch: Colors.deepPurple,
          // visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
      home: Home(),
    );
  }
}
