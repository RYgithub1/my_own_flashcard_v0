
import 'dart:io';

import 'package:moor/ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';




// 作りたいDBは問題と答え
// Teble -> 要注意：moor.dartからの選択のみ読み込める
class Words extends Table {
  // 「=>」の先は関数。getはゲッター
  TextColumn get strQustion => text()();   // TextColumnもmoorのクラス。f12->text()()もmoorのルール
  TextColumn get strAnswer  => text()();

  @override
  // implement primaryKey
  // Set<Column> get primaryKey => super.primaryKey;  // DBのプライマリキー設定に「pr」
  Set<Column> get primaryKey => {strQustion};  // set型は、List型の順番0,2,3,がないバージョン
}


@UseMoor(tables: [Words])
class MyDatabase extends _$MyDatabase{
  // MyDatabase(): super(_openConnection)
  MyDatabase()
    : super(FlutterQueryExcuter.DatabaseFolder(  // リダイレクトコンストラクタ,1/7,読んでいるだけ
      path: "words.db", logStatements: true,
    ),);
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();  // f12->import pathProvider
    final file = File(p.join(dbFolder.path, 'words.db'));  // f12->import dart:io
    return VmDatabase(file);  // f12->import ffi
  });
}