import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/screens/home_screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "フラッシュカード",
      // theme: ThemeData.dark(),
      theme: ThemeData(
        brightness: Brightness.dark,
        fontFamily: "Lanobe",
      ),
      home: HomeScreen(),
    );
  }
}