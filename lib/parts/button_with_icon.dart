// import 'dart:ui' as prefix0;
import 'package:flutter/material.dart';



// 【カスタムWidget作成 -> コンストラクタで呼び出し -> ボタン設定】
// クラスで外だし、他の画面からも共通ボタン形式として活用可能（メソッドよりも広範囲に）
// ボタン用パーツ -> ボタンのフォントサイズや見た目を共通化 ->脳に優しい
class ButtonWithIcon extends StatelessWidget {
  // var onPressed;
  // var icon;
  // var label;
  // 石の中に変えられるvarはだめなのでfinal
  final VoidCallback onPressed; // VoidCallbackの実態は、function関数だった
  final Icon icon;
  final String label;
  // 更にカラーももらう用
  final Color color;


  // ++++++++++++++++++++++++++++++++++++++++++++++++
  // コンストラクタの引数値として渡して、呼び出された方のクラスのプロパティに設定してやる
  // thisで名前付きコンストラクタの設定。下のRaisedButtonと同じものを設定
  // 呼び出し側からとってきた引数各々を、プロパティfinalで設定して、build()にわたす
  // コンストラクタ({})の形でないと引数渡せずエラー
  // ButtonWithIcon({this.onPressed, this.icon, this.label});
  // 更に、呼び出し側からカラーも
  ButtonWithIcon({this.onPressed, this.icon, this.label, this.color});


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: SizedBox(
        width: double.infinity,
        height: 50.0,
        child: RaisedButton.icon(
          onPressed: onPressed,
          icon: icon,
          label: Text(label, style: TextStyle(fontSize:18.0),),
          color: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }



}

