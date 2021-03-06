import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/db/database.dart';
import 'package:my_own_flashcard_v0/main.dart';


enum TestStatus {BEFORE_START, SHOW_QUESTION, SHOW_ANSWER, FINISHED}


// テスト画面
class TestScreen extends StatefulWidget {
  // var isIncludedMemorizedWords;
  final bool isIncludedMemorizedWords;  // 全てwidget(石) -> 石は変えられないのでvar使えない -> final。型はyesNo

  // home画面からプロパティの値を受け取りたい->コンストラクタ定義 -> ({this.xxx})
  TestScreen({this.isIncludedMemorizedWords});

  @override
  _TestScreenState createState() => _TestScreenState();
}




class _TestScreenState extends State<TestScreen> {
  int _numberOfQuestion = 777;
  String _txtQuestion = "問題";
  // String _txtQuestion = "";
  String _txtAnswer = "答え";
  // String _txtAnswer = "";
  bool _isMemorized = false;

  bool _isQuestionCardVisible = false;
  bool _isAnswerCardVisible = false;
  bool _isCheckBoxVisible = false;
  bool _isFabVisible = false;
  


  List<Word> _testDataList = List();
  TestStatus _testStatus;
  int _index = 0;  // 今何もんめ
  Word _currentWord;


  // ++++++++++++++++++++++++++++++++++++++
  @override
  void initState() {
    super.initState();
    _getTestData();
  }
  void _getTestData() async{
    // 暗記済みデータを含むか除くか（画面遷移時に持参している）
    if (widget.isIncludedMemorizedWords) {  //  含む場合
      _testDataList = await database.allWords;
    }else{  // 除く場合
      _testDataList = await database.allWordsExcludedMemorized;
    }

    // _testDataList.shuffle();
    // _testStatus = TestStatus.BEFORE_START;
    // _index = 0;

    _testDataList.shuffle();
    _testStatus = TestStatus.BEFORE_START;
    print(_testDataList.toString());  // ここでエラーDB; SqliteException(1): no such column: is_memorized, SQL logic error (code 1)
    setState(() {
      _isQuestionCardVisible = false;
      _isAnswerCardVisible = false;
      _isCheckBoxVisible = false;
      _isFabVisible = true;

      _numberOfQuestion = _testDataList.length;  // 上で問題数がわかったので
    });
  }

    
    
      // +++++++++++++++++++++++++++++++++++++++
      @override
      Widget build(BuildContext context) {
        // var isInclude = widget.isIncludedMemorizedWords;  //渡せている判定、覚えたtrue,覚えずfalse
        return Scaffold(
          appBar: AppBar(
            title: Text("確認テスト"),
            centerTitle: true,
          ),
          // floatingActionButton: FloatingActionButton(
          floatingActionButton: _isFabVisible
            ? FloatingActionButton(
              // onPressed: () => print("pushed"),
              onPressed: () => _goNextStatus(),  // FABでテスト画面遷移の条件分岐
              child: Icon(Icons.skip_next),
              tooltip: "次に進む",
            )
            :null,  // さんこう演算子

          // body: Center(child: Text("テスト画面: $isInclude"),),
          body: Column(
            children: [
              SizedBox(height: 20.0),
              _numberOfQuestionsPart(),
              SizedBox(height: 20.0),
              _questionCardPart(),
              SizedBox(height: 20.0),
              _answerCardPart(),
              SizedBox(height: 20.0),
              _isMemorizedCheakPart(),
            ],
          )
        );
      }
    
    
      // 残り問題数表示部分
      Widget _numberOfQuestionsPart() {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,  // Rowをcenterに並べる、AxisAlingnment
          children: <Widget>[
            Text(
              "残り問題数",
              style: TextStyle(fontSize: 14.0),
            ),
            SizedBox(width: 30.0),
            Text(
              _numberOfQuestion.toString(),  // int->Srtring
              style: TextStyle(fontSize: 24.0),
            ),
          ],
        );
      }
      // 問題カード表示部分
      Widget _questionCardPart() {

        if( _isQuestionCardVisible){
          return Stack(  // 下方コード程後に積み重ねる
            alignment: Alignment.center,  // 真ん中に合わせてStackするため
            children: [
              Image.asset("assets/images/image_flash_question.png"),
              Text(  // DBデータを抽出表示ゆえ変数化しておく
                _txtQuestion,
                style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
              ),
            ],
          );
        }else{
          return Container();
        }

      }
      // 答えカード表示部分
      Widget _answerCardPart() {
        if(_isAnswerCardVisible){
          return Stack(
            alignment: Alignment.center,  // 真ん中に合わせてStackするため
            children: [
              Image.asset("assets/images/image_flash_answer.png"),
              Text(
                _txtAnswer,
                style: TextStyle(color: Colors.grey[800], fontSize: 20.0),
              ),
            ],
          );
        }else {
          return Container();
        }
     
      }
      // 暗記済みチェック部分
      Widget _isMemorizedCheakPart() {
        if(_isCheckBoxVisible){
          // 《checkBox左側の場合》 -> CheckBox書いて、Text
          // return Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Checkbox(
          //       value: _isMemorized,
          //       onChanged: (value){
          //         setState(() {
          //           _isMemorized = value;
          //         });
          //       },
          //     ),
          //     Text(
          //       "暗記済みにチェック入れて！",
          //       style: TextStyle(fontSize: 12.0),
          //     ),
          //   ],
          // );
          // 《checkBox右側の場合》->CheckboxListTileの中に、 title: Text()
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),  // EdgeInsets.symmetric
            child: CheckboxListTile(
              value: _isMemorized,  // 暗記済みか否かで,チェックつけるか否か
              onChanged: (value){  // f12(onChanged)->f12(valueChanged)->function(argument)->上のvalueを受ける関数式
                setState(() {
                  _isMemorized = value;
                });
              },
              title: Text(
                "暗記済みにチェック入れて！",
                style: TextStyle(fontSize: 12.0),
              ),
            ),
          );
        }else {
          return Container();
        }
      }



  _goNextStatus() {
    switch (_testStatus) {
      case TestStatus.BEFORE_START:
        _testStatus = TestStatus.SHOW_QUESTION;
        _showQuestion();
        break;
      case TestStatus.SHOW_QUESTION:
        _testStatus = TestStatus.SHOW_ANSWER;
        break;
      case TestStatus.SHOW_ANSWER:
        if(_numberOfQuestion <= 0){
          _testStatus = TestStatus.FINISHED;
        }else{
          _testStatus = TestStatus.SHOW_QUESTION;
        }
        break;
      case TestStatus.FINISHED:
        break;
    }
  }

  void _showQuestion() {
    _currentWord = _testDataList[_index];
    setState(() {
      _isQuestionCardVisible = true;
      _isAnswerCardVisible = false;
      _isCheckBoxVisible = false;
      _isFabVisible = true;

      _txtQuestion = _currentWord.strQuestion;
    });
    _numberOfQuestion -= 1;
    _index += 1;
  }



}