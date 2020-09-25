import 'dart:io';
import 'package:moor/ffi.dart';
// import 'package:moor_ffi/moor_ffi.dart';
import 'package:moor/moor.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

part 'database.g.dart';   // 後々、リファ「flutter packages pub run build_runner watch」でコード生成して、ファイル自動作成、赤波消える



// 作りたいDBは問題と答え
// Teble -> 要注意：moor.dartからの選択のみ読み込める
// class Words extends Table {  // {とのスペースがあいていた
class Words extends Table{
  // 「=>」の先は関数。getはゲッター
  TextColumn get strQuestion => text()();   // TextColumnもmoorのクラス。f12->text()()もmoorのルール
  TextColumn get strAnswer => text()();

  @override
  // implement primaryKey
  // Set<Column> get primaryKey => super.primaryKey;  // DBのプライマリキー設定に「pr」
  Set<Column> get primaryKey => {strQuestion};  // set型は、List型の順番0,2,3,がないバージョン
}



// データベース表記ここｐ
LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async{
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();  // f12->import pathProvider
    final file = File(p.join(dbFolder.path, 'words.db'));  // f12->import dart:io
    return VmDatabase(file);  // f12->import ffi
  });
}



// moorの使い方定形パターン
@UseMoor(tables: [Words])
class MyDatabase extends _$MyDatabase{
  MyDatabase()
      : super(_openConnection());

  @override
  // int get schemaVersion => throw UnimplementedError();  // エラーまず赤文字追う ->挙動ギャップ追う
  int get schemaVersion => 2;  // DBのスキーマバージョン設定

  // database -> Future )) moor refarence -> DB４つの作成 -> いつもDartでこう書く定形-> CRUD rule、クエリ作成
  // create >    ...  DBからloadして、ｐropertyにしてget
  Future addWord(Word word) => into(words).insert(word);  //(Word word)はDBの１行分、
  // read >
  Future<List<Word>> get allWords => select(words).get();  // using getter to read
  // update >
  Future updateWord(Word word) => update(words).replace(word);  // write or replace
  // delete >
  Future detleteWord(Word word) => (delete(words)..where((table) => table.strQuestion.equals(word.strQuestion))).go();
  // words対象、where関数、tableでフィルター、table内のstrQuestionの引数、入れた(Word word)とequalなら,削除go()


}
