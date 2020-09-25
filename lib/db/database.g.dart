// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Word extends DataClass implements Insertable<Word> {
  final String strQuestion;
  final String strAnswer;
  Word({@required this.strQuestion, @required this.strAnswer});
  factory Word.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final stringType = db.typeSystem.forDartType<String>();
    return Word(
      strQuestion: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_question']),
      strAnswer: stringType
          .mapFromDatabaseResponse(data['${effectivePrefix}str_answer']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || strQuestion != null) {
      map['str_question'] = Variable<String>(strQuestion);
    }
    if (!nullToAbsent || strAnswer != null) {
      map['str_answer'] = Variable<String>(strAnswer);
    }
    return map;
  }

  WordsCompanion toCompanion(bool nullToAbsent) {
    return WordsCompanion(
      strQuestion: strQuestion == null && nullToAbsent
          ? const Value.absent()
          : Value(strQuestion),
      strAnswer: strAnswer == null && nullToAbsent
          ? const Value.absent()
          : Value(strAnswer),
    );
  }

  factory Word.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Word(
      strQuestion: serializer.fromJson<String>(json['strQuestion']),
      strAnswer: serializer.fromJson<String>(json['strAnswer']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'strQuestion': serializer.toJson<String>(strQuestion),
      'strAnswer': serializer.toJson<String>(strAnswer),
    };
  }

  Word copyWith({String strQuestion, String strAnswer}) => Word(
        strQuestion: strQuestion ?? this.strQuestion,
        strAnswer: strAnswer ?? this.strAnswer,
      );
  @override
  String toString() {
    return (StringBuffer('Word(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(strQuestion.hashCode, strAnswer.hashCode));
  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      (other is Word &&
          other.strQuestion == this.strQuestion &&
          other.strAnswer == this.strAnswer);
}

class WordsCompanion extends UpdateCompanion<Word> {
  final Value<String> strQuestion;
  final Value<String> strAnswer;
  const WordsCompanion({
    this.strQuestion = const Value.absent(),
    this.strAnswer = const Value.absent(),
  });
  WordsCompanion.insert({
    @required String strQuestion,
    @required String strAnswer,
  })  : strQuestion = Value(strQuestion),
        strAnswer = Value(strAnswer);
  static Insertable<Word> custom({
    Expression<String> strQuestion,
    Expression<String> strAnswer,
  }) {
    return RawValuesInsertable({
      if (strQuestion != null) 'str_question': strQuestion,
      if (strAnswer != null) 'str_answer': strAnswer,
    });
  }

  WordsCompanion copyWith(
      {Value<String> strQuestion, Value<String> strAnswer}) {
    return WordsCompanion(
      strQuestion: strQuestion ?? this.strQuestion,
      strAnswer: strAnswer ?? this.strAnswer,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (strQuestion.present) {
      map['str_question'] = Variable<String>(strQuestion.value);
    }
    if (strAnswer.present) {
      map['str_answer'] = Variable<String>(strAnswer.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WordsCompanion(')
          ..write('strQuestion: $strQuestion, ')
          ..write('strAnswer: $strAnswer')
          ..write(')'))
        .toString();
  }
}

class $WordsTable extends Words with TableInfo<$WordsTable, Word> {
  final GeneratedDatabase _db;
  final String _alias;
  $WordsTable(this._db, [this._alias]);
  final VerificationMeta _strQuestionMeta =
      const VerificationMeta('strQuestion');
  GeneratedTextColumn _strQuestion;
  @override
  GeneratedTextColumn get strQuestion =>
      _strQuestion ??= _constructStrQuestion();
  GeneratedTextColumn _constructStrQuestion() {
    return GeneratedTextColumn(
      'str_question',
      $tableName,
      false,
    );
  }

  final VerificationMeta _strAnswerMeta = const VerificationMeta('strAnswer');
  GeneratedTextColumn _strAnswer;
  @override
  GeneratedTextColumn get strAnswer => _strAnswer ??= _constructStrAnswer();
  GeneratedTextColumn _constructStrAnswer() {
    return GeneratedTextColumn(
      'str_answer',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [strQuestion, strAnswer];
  @override
  $WordsTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'words';
  @override
  final String actualTableName = 'words';
  @override
  VerificationContext validateIntegrity(Insertable<Word> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('str_question')) {
      context.handle(
          _strQuestionMeta,
          strQuestion.isAcceptableOrUnknown(
              data['str_question'], _strQuestionMeta));
    } else if (isInserting) {
      context.missing(_strQuestionMeta);
    }
    if (data.containsKey('str_answer')) {
      context.handle(_strAnswerMeta,
          strAnswer.isAcceptableOrUnknown(data['str_answer'], _strAnswerMeta));
    } else if (isInserting) {
      context.missing(_strAnswerMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {strQuestion};
  @override
  Word map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return Word.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  $WordsTable createAlias(String alias) {
    return $WordsTable(_db, alias);
  }
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $WordsTable _words;
  $WordsTable get words => _words ??= $WordsTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [words];
}
