// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/parts/button_with_icon.dart';
import 'package:my_own_flashcard_v0/screens/test_screen.dart';
import 'package:my_own_flashcard_v0/screens/word_list_screen.dart';
// import 'dart:html';



class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}



class _HomeScreenState extends State<HomeScreen> {
  bool isIncludedMemorizedWords = false;  // 暗記した単語を含めるかのbool用


  // 【Method】+++++++++++++++++++++++++++++++++++++++++++++
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
            // ----- テストボタン -----
            // 各々引数へ渡してあげるために設定
            ButtonWithIcon(
              // onPressed: () => print("テスト"),
              // onPressed: () => _startTestScreen(),
              onPressed: () => _startTestScreen(context),  // 押下してテスト画面へ遷移
              icon: Icon(Icons.play_arrow),
              label: "Test",
              color: Colors.orange,
            ),
            SizedBox(height: 10.0), // デザインゆえボックススペース挿入
            // ----- ラジオボタン -----
            _radioButtons(),
            SizedBox(height: 30.0), // デザインゆえボックススペース挿入
            // ----- 単語一覧ボタン -----
            ButtonWithIcon(
              // onPressed: () => print("単語一覧"),
              // onPressed: () => _startWordListScreen(),
              onPressed: () => _startWordListScreen(context),  // 押下して単語一覧画面へ遷移
              icon: Icon(Icons.list),
              label: "単語一覧をみる",
              color: Colors.grey,
            ),
            SizedBox(height: 50.0), // デザインゆえボックススペース挿入
            // ----- 著作権 -----
            Text(
              "Copyright (C) 2020 R inc. All Rights Reserved.",
              style: TextStyle(fontFamily: "Mont"),  // 特定のテキストだけfont変更
            ),
            SizedBox(height: 25.0), // デザインゆえボックススペース挿入
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

  Widget _radioButtons() {
    return Padding(
      padding: const EdgeInsets.only(left: 70.0),
      child: Column(
        children: <Widget>[
          RadioListTile(
            value: false, // 今回覚えた単語を含む事をyesにしているので、ここfalse(coz official)
            groupValue: isIncludedMemorizedWords, // 2択はbool -> propertyを上で定義
            onChanged: (value) => _onRadioSelected(value),  // f12(RadioListTile) -> f12(onChanged) -> If true/false, [onChanged] can be called with [value] ->valueが引数に必要と判断
            title: Text("覚えた単語を除く", style: TextStyle(fontSize: 16.0),),
          ),
          RadioListTile(
            value: true, // 上ラジオを背反
            groupValue: isIncludedMemorizedWords, // 上ラジオと同様
            onChanged: (value) => _onRadioSelected(value),
            title: Text("覚えた単語も含む", style: TextStyle(fontSize: 16.0),),
          ),
        ],
      ),
    );
  }


  // 【Supplymentary Method】++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  // ラジオボタン押下、押されるものが変わるを表す
  // Widget _onRadioSelected() {
  // Widget _onRadioSelected(value) {  // value引数受ける
  void _onRadioSelected(value) {  // value引数受ける
    setState(() {
      isIncludedMemorizedWords = value; // groupValueの値を変えたげる
      print("ラジオで$valueを選択");
    });
  }

  // 単語一覧画面へ遷移
  // void _startWordListScreen() {
  void _startWordListScreen(BuildContext context) {  // added 1 awgument
    // Navigator.push(context, route);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => WordListScreen(),),  // 引数渡さないので書かず、次画面でもコンストラクタ不要
    );
  }

  // テスト画面へ遷移
  // _startTestScreen() {}
  void _startTestScreen(BuildContext context) {
    Navigator.push(
      context,
      // MaterialPageRoute(builder: (context) => TestScreen(),),  // 引数を次画面で渡す
      MaterialPageRoute(builder: (context) => TestScreen(isIncludedMemorizedWords: isIncludedMemorizedWords,),),
    );
  }




}