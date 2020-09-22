import 'package:flutter/material.dart';
// import 'dart:html';



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
            Expanded(child: Image.asset("assets/images/image_title.png"),),
            _titleText(),
            // ----- 横線 -----
            Divider(  // デフォルト上下8pxずつの箱 ->上下等間隔で開いていく
              height: 30.0,
              color: Colors.white,
              indent: 35.0,  // 線の左右
              endIndent: 35.0,
            ),
            // TODO: テストボタン
            // TODO: ラジオボタン
            // TODO: 単語一覧ボタン
            Text(
              "Copyright (C) 2020 R inc. All Rights Reserved.",
              style: TextStyle(fontFamily: "Mont"),  // 特定のテキストだけfont変更
            ),
          ],
        ),
      ),
    );
  }


  Widget _titleText() {
    return Column(
      children: <Widget>[
        Text(
          "ふらっしゅかーど",
          style: TextStyle(fontSize: 40.0),
        ),
        Text(
          "My Flash Cards",
          style: TextStyle(fontSize: 24.0, fontFamily: "Mont",),
        ),
      ]
    );
  }







}