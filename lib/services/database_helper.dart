import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    String path = join(await getDatabasesPath(), 'favorites.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''
          CREATE TABLE favorites (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            itemId INTEGER NOT NULL,
            title TEXT NOT NULL,
            posterPath TEXT NOT NULL,
            type TEXT NOT NULL,
            year TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> addFavorite({
    required int itemId,
    required String title,
    required String posterPath,
    required String type,
    required String year,
  }) async {
    final db = await database;
    return await db.insert(
      'favorites',
      {
        'itemId': itemId,
        'title': title,
        'posterPath': posterPath,
        'type': type,
        'year': year,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> isFavorite(int itemId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'favorites',
      where: 'itemId = ?',
      whereArgs: [itemId],
    );
    return maps.isNotEmpty;
  }

  Future<List<Map<String, dynamic>>> getFavorites(String type) async {
    final db = await database;
    return await db.query(
      'favorites',
      where: 'type = ?',
      whereArgs: [type],
    );
  }

  Future<int> removeFavorite(int itemId) async {
    final db = await database;
    return await db.delete(
      'favorites',
      where: 'itemId = ?',
      whereArgs: [itemId],
    );
  }
}