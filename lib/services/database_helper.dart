import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DatabaseHelper {
  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final directory = await getApplicationDocumentsDirectory();
    final path = join(directory.path, 'app.db');
    return await databaseFactoryFfi.openDatabase(
      path,
      options: OpenDatabaseOptions(
        onCreate: (db, version) async {
           await db.execute(
            "CREATE TABLE users(id INTEGER PRIMARY KEY,name VARCHAR(128) NOT NULL, email TEXT UNIQUE, password TEXT)",
           );
          await db.execute(
            "CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, price REAL, description TEXT, imagePath TEXT)",
          );
        },
        version: 1,
      ),
    );
  }
}
