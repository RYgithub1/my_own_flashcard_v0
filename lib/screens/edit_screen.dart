import 'dart:html';

import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/screens/word_list_screen.dart';



// 新しい単語の登録画面
class EditScreen extends StatefulWidget {
  @override
  _EditScreenState createState() => _EditScreenState();
}




class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  // ++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return WillPopScope(  // Scaffold >WrapWidget >WillPopScope Class使う -> pushReplacementゆえhomeScreenに戻ってしまい困る、を解決できる
      onWillPop: () => _baclToWordListScreen(),  // F12 > functionゆえ関数を用意してやればよい、戻り値はFuture<bool>
        child: Scaffold(
        appBar: AppBar(
          title: Text("新しい単語の登録"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(  // SingleChildScrollViewでwrap -> 画面サイズ虎エラー消す -> 自動上スクロール
          child: Column(
            children: <Widget>[
              SizedBox(height: 30.0),
              Center(
                child: Text(
                  "QA入力して登録ボタン押下して",
                  style: TextStyle(fontSize: 12.0),
                ),
              ),
              SizedBox(height: 30.0),
              // 問題入力部分
              _questionInputPart(),
              // 答え入力部分
              _answerInputPart(),
              SizedBox(height: 30.0),
            ],
          ),
        ),
      ),
    );
  }


  // 【supplyment】++++++++++++++++++++++++++++++++++
  Widget _questionInputPart() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            "問題",
            style: TextStyle(fontSize: 24.0,),
          ),
          TextField(
            controller: questionController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,  // 入力文字がcenter
          ),
        ],
      ),
    );
  }

  Widget _answerInputPart() {  // _questionInputPart()と同様形式ゆえコピ
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        children: <Widget>[
          SizedBox(height: 30.0),
          Text(
            "答え",
            style: TextStyle(fontSize: 24.0,),
          ),
          TextField(
            controller: answerController,
            keyboardType: TextInputType.text,
            style: TextStyle(fontSize: 30.0),
            textAlign: TextAlign.center,  // 入力文字がcenter
          ),
        ],
      ),
    );
  }

  // _baclToWordListScreen() {  // データフローよりpushReplacementで入れ替える
  // void _baclToWordListScreen() {
  Future<bool> _baclToWordListScreen() {  // boolでtrueならpop返し、falseならpop返さない
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WordListScreen(),),
    );
    return Future.value(false);  // この画面でpopするとhome、homeに戻さないで単語一覧に戻したいから、false指定、Replacement
  }




}