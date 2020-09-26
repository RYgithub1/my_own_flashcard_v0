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

  BoolColumn get isMemorized => boolean().withDefault(Constant(false))();  // defaltはfalse、暗記済みじゃないと設定...最後の()!!!
  // withDefaultデフォルト値を入れる仕組み

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
  int get schemaVersion => 2;  // DBのスキーマバージョン設定。。。。一旦gDart消してwatchで、変数定義がgDartに追加される
  MigrationStrategy get migration => MigrationStrategy(  // この()はムーアの書き方統合処理
    onCreate: (Migrator m){
      // return m.createAllTables();
      return m.createAll();
    },
    onUpgrade: (Migrator m, int from, int to) async {
      if (from == 1) {
        await m.addColumn(words, words.isMemorized);
      }
    }
  );

  // <<クエリメソッドの作成>>
  // database -> Future )) moor refarence -> DB４つの作成 -> いつもDartでこう書く定形-> CRUD rule、クエリ作成
  // < create >    ...  DBからloadして、ｐropertyにしてget
  Future addWord(Word word) => into(words).insert(word);  //(Word word)はDBの１行分、
  // < read >
  Future<List<Word>> get allWords => select(words).get();  // using getter to read。ここでは全てのデータを取得するためのmoor
  // （< read > 暗記済み単語の除外）以下追加、全てのデータでなく、特定データの取得read用->確認テストで個別抽出に必要
  Future<List<Word>> get allWordsExcludedMemorized => (select(words)..where((table) => table.isMemorized.equals(false))).get();
  
  // < update >
  Future updateWord(Word word) => update(words).replace(word);  // write or replace
  // < delete >
  Future detleteWord(Word word) => (delete(words)..where((table) => table.strQuestion.equals(word.strQuestion))).go();
  // words対象、where関数、tableでフィルター、table内のstrQuestionの引数、入れた(Word word)とequalなら,削除go()


}
