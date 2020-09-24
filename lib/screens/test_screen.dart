import 'package:flutter/material.dart';




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
  @override
  Widget build(BuildContext context) {
    var isInclude = widget.isIncludedMemorizedWords;  //渡せている判定、覚えたtrue,覚えずfalse
    return Scaffold(
      body: Center(child: Text("テスト画面: $isInclude"),),
    );
  }
}