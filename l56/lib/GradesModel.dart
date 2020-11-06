import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';
import 'grades.dart';

class GradeModel{
  Future <int> insertGrade(StudentGrade grade) async{
    final db = await DBUtils.init();
    return db.insert(
      'grades',
      grade.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }
  Future<void> updateGrade(StudentGrade grade) async {
    final db = await DBUtils.init();
    await db.update(
      'grades',
      grade.toMap(),
      where: 'id = ?',
      whereArgs: [grade.id],
    );
  }

  Future<int> deleteGradeWithId(int id) async {
    final db = await DBUtils.init();
    await db.delete(
      'grades',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<StudentGrade>> getAllGrades() async {
    final db = await DBUtils.init();
    final List<Map<String, dynamic>> maps = await db.query('grades');
    List<StudentGrade> result = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        result.add(StudentGrade.fromMap(maps[i]));
      }
    }
    return result;
  }
  Future <dynamic> getId(int id) async {
    final db = await DBUtils.init();
    await db.query(
      'grades',
      where: 'id = ?',
      whereArgs: [id],
    );
    return id;
  }
}
