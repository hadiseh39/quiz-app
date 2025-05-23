import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/question.dart';

class QuestionDB {
  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await initDB();
    return _db!;
  }

  Future<Database> initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'questions.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE questions (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            question TEXT,
            option1 TEXT,
            option2 TEXT,
            option3 TEXT,
            option4 TEXT,
            correctAnswer TEXT,
            isLearned INTEGER
          )
        ''');
      },
    );
  }

  Future<int> insertQuestion(Question question) async {
    final db = await database;
    return await db.insert('questions', question.toMap());
  }

  Future<List<Question>> getAllQuestions() async {
    final db = await database;
    final maps = await db.query('questions', orderBy: 'id DESC');
    return maps.map((map) => Question.fromMap(map)).toList();
  }

  Future<int> updateIsLearned(int id, bool isLearned) async {
    final db = await database;
    return await db.update(
      'questions',
      {'isLearned': isLearned ? 1 : 0},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<int> deleteQuestion(int id) async {
    final db = await database;
    return await db.delete(
      'questions',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
