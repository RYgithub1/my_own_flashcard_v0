import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/db/database.dart';
import 'package:my_own_flashcard_v0/main.dart';
import 'package:my_own_flashcard_v0/screens/edit_screen.dart';
import 'package:toast/toast.dart';
// import 'package:my_own_flashcard_v0/db/database.dart';
// import 'package:my_own_flashcard_v0/main.dart';



class WordListScreen extends StatefulWidget {
  @override
  _WordListScreenState createState() => _WordListScreenState();
}




class _WordListScreenState extends State<WordListScreen> {
  List<Word> _wordList = List();


  // ++++++++++++++++++++++++++++++++++++++++++++++=
  @override
  // void initState() await{  // 石が変わるので -> エラー -> initState()内はasync-await使えず->別メソッド->そっちでasync-await
  void initState() {
    super.initState();

    // DBからdataとってくる read
    // await database.allWords;  // 戻り値futureだった
    _getAllWords();
  }


  // ++++++++++++++++++++++++++++++++++++++++++
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("単語一覧"),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(  // "FAB"
        // onPressed: () =>  print("FAB"),
        onPressed: () =>  _addNewWord(),
        child: Icon(Icons.add),
        tooltip: "新しい単語の登録",
        hoverColor: Colors.blue,
      ),
      // body: Center(child: Text("単語一覧画面")),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _wordListWidget(),
      ),
    );
  }


  // ++++++++++++++++++++++++++++++++++++++++++
  // FloatingButtonでの往来
  void _addNewWord() {
    // push()で重ねてるのでpush()でなく除くpop()。
    // 登録情報を、全画面home_screenに反映する必要がある ->pushReplacementで「往来」
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(status: EditStatus.ADD,),),  // 定形パターン
    );
  }


  void _getAllWords() async{
    _wordList = await database.allWords;  // allWordsの戻り値はList -> global variableとして皆使えるように定義
    // Futureで帰ってくるものをlistに格納
    setState(() {});
  }

  Widget _wordListWidget() {
    return ListView.builder(
      itemCount: _wordList.length,  // required
      itemBuilder: (context, int position) => _wordItem(position),
    );
  }
  Widget _wordItem(int position) {
    return Card(
      elevation: 10.0,  // card height on screen
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(66.0)),
      color: Colors.cyan,
      child: ListTile(
        title: Text(
          "${_wordList[position].strQuestion}",
        ),
        subtitle: Text(
          "${_wordList[position].strAnswer}",
          style: TextStyle(fontFamily: "mont",),
        ),
        onTap: () => _editWord(_wordList[position]),
        onLongPress: () => _deleteWord(_wordList[position]),  // 削除したいデータ１行をargumentで渡す
      ),
    );

  }

  _deleteWord(Word selectedWord) async{
    await database.detleteWord(selectedWord);
    Toast.show(  // 削除完了メッセーじ優しさ
      "delete完了！",
      context,
    );
    // setState(() {});
    // DBデータは消えているけど、画面表示分の_getAllWords()格納が残ってるので画面遷移しないと消えない
    _getAllWords();

  }

  _editWord(Word selectedWord) {  // editScreenのコンストラクタを受ける
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => EditScreen(
          status: EditStatus.EDIT,
          word: selectedWord,
        ),
      ),  // 定形パターン
    );
  }


}