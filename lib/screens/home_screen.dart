import 'package:flutter/material.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: <Widget>[
            Expanded(child: Image.asset("assets/images/image_title/png")),
            _titleText(),
            // TODO: 横線
            // TODO: テストボタン
            // TODO: ラジオボタン
            // TODO: 単語一覧ボタン
            Text("Copyright (C) 2020 R inc. All Rights Reserved.")
          ],
        ),


      ),
    );
  }

  Widget _titleText() {
    return Column(
      children: <Widget>[
        Text("フラッシュカード", style: TextStyle(fontSize: 40.0),),
        Text("My Flash Cards", style: TextStyle(fontSize: 24.0),),
      ]
    );


  }
}