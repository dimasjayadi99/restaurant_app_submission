import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:submission_restauirant_app/data/models/restaurant_list_model.dart';

class DatabaseHelper{
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  static Database? _databaseRestaurant;

  DatabaseHelper._internal();

  Future<Database> get databaseRestaurant async {
    if(_databaseRestaurant != null) return _databaseRestaurant!;
    _databaseRestaurant = await _initDatabaseRestaurant();
    return _databaseRestaurant!;
  }

  Future<Database> _initDatabaseRestaurant() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, "db_restaurant.db");

    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE favorite(
      id TEXT PRIMARY KEY,
      name TEXT,
      description TEXT,
      pictureId TEXT,
      city TEXT,
      rating REAL
    )
    ''');
  }

  /// insert favorite data
  Future<void> insertFavoriteRestaurant(Restaurant restaurant) async {
    final db = await databaseRestaurant;
    await db.insert('favorite', restaurant.toJson());
  }

  /// list favorite
  Future<List<Restaurant>> fetchListFavoriteRestaurant() async {
    final db = await databaseRestaurant;
    List<Map<String, dynamic>> mapping = await db.query('favorite');

    return mapping.map((item) => Restaurant.fromJson(item)).toList();
  }

  /// check exist data
  Future<bool> isFavoriteRestaurant(String id) async {
    final db = await databaseRestaurant;
    final result = await db.query(
      'favorite',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty;
  }

  /// delete from favorite
  Future<bool> removeFavoriteRestaurant(String id) async {
    final db = await databaseRestaurant;
    int result = await db.delete('favorite', where: 'id = ?', whereArgs: [id]);

    return result > 0;
  }
}