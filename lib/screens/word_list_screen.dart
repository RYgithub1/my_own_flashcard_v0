import 'package:flutter/material.dart';
import 'package:my_own_flashcard_v0/screens/edit_screen.dart';



class WordListScreen extends StatefulWidget {
  @override
  _WordListScreenState createState() => _WordListScreenState();
}

class _WordListScreenState extends State<WordListScreen> {


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
      body: Center(child: Text("単語一覧画面")),
    );
  }


  // ++++++++++++++++++++++++++++++++++++++++++
  // FloatingButtonでの往来
  void _addNewWord() {
    // push()で重ねてるのでpush()でなく除くpop()。
    // 登録情報を、全画面home_screenに反映する必要がある ->pushReplacementで「往来」
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => EditScreen(),),  // 定形パターン
    );
  }




}