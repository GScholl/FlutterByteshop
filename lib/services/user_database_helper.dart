import 'package:bcrypt/bcrypt.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/user.dart';
import 'database_helper.dart';
class UserDatabaseHelper {
  static final UserDatabaseHelper _instance = UserDatabaseHelper._internal();
  factory UserDatabaseHelper() => _instance;
  UserDatabaseHelper._internal();

  Database? _database;
 
  get databaseHelper => DatabaseHelper();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await databaseHelper.database;
    return _database!;
  }

  
  Future<void> insertUser(User user) async {
    final db = await database;
    user.password = BCrypt.hashpw(user.password, BCrypt.gensalt());
    await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<bool> emailExists(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ? ',
      whereArgs: [email],
    );
    return maps.isNotEmpty;
  }

  Future<User?> getUser(String email, String password) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
    if (!maps.isNotEmpty) {
      return null;
    }
    if (!BCrypt.checkpw(password, maps.first['password'].toString())) {
      return null;
    }
    return User.fromMap(maps.first);
  }
}
