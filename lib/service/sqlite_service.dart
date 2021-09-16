import 'package:restaurant_app_submission_1/model/restaurant.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteService {
  static SQLiteService? _sqLiteService;
  static String _tableName = "favourite_restaurant";
  static late Database _database;
  SQLiteService._internal() {
    _sqLiteService = this;
  }

  factory SQLiteService() => _sqLiteService ?? SQLiteService._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  Future<Database> _initializeDb() async {
    var dbPath = await getDatabasesPath();
    var db = openDatabase(
      join(dbPath, 'favourite_restaurant.db'),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_tableName (id TEXT PRIMARY KEY,
        name TEXT,
        pictureId TEXT,
        city TEXT,
        rating TEXT,
        isFavourite INTEGER) ''');
      },
      version: 1,
    );
    return db;
  }

  Future<void> addFavouriteRestaurant(Restaurant restaurant, bool isFavourite) async {
    final Database db = await database;
    await db.insert(_tableName, restaurant.restaurantToMap(isFavourite));
    print('Data Saved');
  }

  Future<void> deleteFavouriteRestaurantById(String id) async {
    final Database db = await database;
    await db.delete(_tableName, where: 'id = ?', whereArgs: [id]);
    print('Data Deleted');
  }

  Future<List<Restaurant>> getAllFavouriteRestaurant() async {
    final Database db = await database;
    List<Map<String, dynamic>> result = await db.query(_tableName,);
    return result.map((e) => Restaurant.fromJson(e)).toList();
  }
}
