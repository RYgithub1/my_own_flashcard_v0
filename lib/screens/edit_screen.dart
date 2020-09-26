// import 'dart:html';
// import 'package:my_own_flashcard_v0/main.dart';
import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/db/database.dart';
import 'package:my_own_flashcard_v0/main.dart';
import 'package:my_own_flashcard_v0/screens/word_list_screen.dart';
import 'package:toast/toast.dart';
// import 'package:moor_ffi/database.dart';
import 'package:sqlite3/src/api/exception.dart';  // for tryCatchFinally


enum EditStatus { ADD , EDIT }  //  長押しすると削除、短く押すと編集、、、>画面のステータス管理



// 新しい単語の登録画面
class EditScreen extends StatefulWidget {
  // var status;
  final EditStatus status;
  EditScreen({@required this.status, this.word});  // >画面のステータス管理
  final Word word;
  // const EditScreen({Key key, this.word, this.status}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}




class _EditScreenState extends State<EditScreen> {
  TextEditingController questionController = TextEditingController();
  TextEditingController answerController = TextEditingController();

  String _titleText = "";

  bool _isQuestionEnabled;  // enabledの型bool


  @override
  void initState() {  // 状態変化の場合分け、 FAB押下と、行のタップEDIT
    super.initState();
    if (widget.status == EditStatus.ADD){  // widget.
      _isQuestionEnabled = true;
      _titleText = "新しい単語の追加";
      questionController.text = "";
      answerController.text = "";
    } else {
      _isQuestionEnabled = false;
      _titleText = "登録した単語の修正";
      questionController.text = widget.word.strQuestion;
      answerController.text = widget.word.strAnswer;
    }
  }

  // ++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return WillPopScope(  // Scaffold >WrapWidget >WillPopScope Class使う -> pushReplacementゆえhomeScreenに戻ってしまい困る、を解決できる
      onWillPop: () {
        var backToWordListScreen = _backToWordListScreen();
                return backToWordListScreen;
      },  // F12 > functionゆえ関数を用意してやればよい、戻り値はFuture<bool>
        child: Scaffold(
        appBar: AppBar(
          // title: Text("新しい単語の登録"),
          title: Text(_titleText),  // 画面遷移に合わせてタイトル変更
          centerTitle: true,
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.check),
              color: Colors.pink,
              // onPressed: () => _insertWord(),  // 処理分岐発生ゆえ、分岐用メソで
              onPressed: () => _onWordRegistered(),
            ),
          ],

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
            enabled: _isQuestionEnabled,// 遷移画面で「問題」はプライマリキーに設定しているので変更不可に.プロパティ作成して
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

  // _backToWordListScreen() {  // データフローよりpushReplacementで入れ替える
  // void _backToWordListScreen() {
  Future<bool> _backToWordListScreen() {  // boolでtrueならpop返し、falseならpop返さない
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => WordListScreen(),),
    );
    return Future.value(false);  // この画面でpopするとhome、homeに戻さないで単語一覧に戻したいから、false指定、Replacement
  }


  _insertWord() async{
    if (questionController.text == "" || answerController.text == ""){  // QA両方登録していないと進めませんif
      // QA登録toastメッセージ
      Toast.show(
        "QAn両方登録しないと進めん",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
      return;
    }
    // print("ok");
    var word = Word(      // var for inside of method.. DB定型のcreateを利用
      strQuestion: questionController.text,
      strAnswer: answerController.text,
    );

    // 同じ単語登録不可の例外メッセージ
    try{  // 成功時
      await database.addWord(word);  // database.dartのaddWordを利用。(Word word)を受け渡し
      print("ok?");
      questionController.clear();  //DB登録後に、入力欄をクリアにする. DB登録、登録待ってからクリアゆえasync
      answerController.clear();
      // 登録完了toastメッセージ
      Toast.show(
        "登録完了！",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
    } on SqliteException catch (e) {  // 失敗時 ,, SqliteExceptionでConsoleに流れる
      Toast.show(
        "この問題は既に登録済みです..$e",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
    }
  }


  _onWordRegistered() {
    if (widget.status == EditStatus.ADD) {
      _insertWord();
    } else {
      _updateWord();
    }
  }



  void _updateWord() async{
    if (questionController.text == "" || answerController.text == ""){
      Toast.show(
        "QAn両方登録しないと進めん",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
      return;
    }
    var word = Word(      // var for inside of method.. DB定型のcreateを利用
      strQuestion: questionController.text,
      strAnswer: answerController.text,
      isMemorized: false,  //
    );
    try{
      await database.updateWord(word);
      _backToWordListScreen();  // 編集後に、単語一覧を更新したいので。pushReplacementで開いていた
      Toast.show(
        "編集完了したー",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
    }on SqliteException catch (e) {  // 失敗時 ,, SqliteExceptionでConsoleに流れる
      Toast.show(
        "問題が発生して登録できんかったー。$e",
        context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.CENTER,
      );
      return;
    }

  }


}