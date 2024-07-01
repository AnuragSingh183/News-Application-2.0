import 'package:sqflite/sqflite.dart' as sql;
import 'package:path/path.dart' as path;

class DBHelper {
  static Future<sql.Database> database() async {
    final dbPath = await sql.getDatabasesPath();
    return sql.openDatabase(path.join(dbPath, 'news.db'),
        onCreate: (db, version) {
      db.execute(
          'CREATE TABLE fav_news(id TEXT PRIMARY KEY, title TEXT, description TEXT, more TEXT, image TEXT, content TEXT, author TEXT, publishedAt TEXT)');
    }, version: 1);
  }

  static Future<void> insert(String table, Map<String, Object> data) async {
    final db = await DBHelper.database();
    db.insert(table, data, conflictAlgorithm: sql.ConflictAlgorithm.replace);
  }

  static Future<List<Map<String, dynamic>>> getData(String table) async {
    final db = await DBHelper.database();
    return db.query(table);
  }

  static Future<void> deleteFavorites(String table, String id) async {
    final db = await DBHelper.database();
    db.delete(
      table, where: "id = ?", whereArgs: [id]
    );
  }
}
