import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils {
  static Future<Database> init() async {
    var database = openDatabase(
      path.join(await getDatabasesPath(), 'grades_manager.db'),
      onCreate: (db, version) {
        db.execute(
            'CREATE TABLE grades(id INTEGER PRIMARY KEY, sid TEXT, grade TEXT)');
      },
      version: 1,
    );
    return database;
  }
}
