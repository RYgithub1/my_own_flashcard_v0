import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/screens/home_screen.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "フラッシュカード",
      theme: ThemeData.dark(),
      home: HomeScreen(),
    );
  }
}