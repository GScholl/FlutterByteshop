import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../models/product.dart';
import 'database_helper.dart';

class ProductDatabaseHelper {
  static final ProductDatabaseHelper _instance =
      ProductDatabaseHelper._internal();
  factory ProductDatabaseHelper() => _instance;
  ProductDatabaseHelper._internal();

  Database? _database;
  get databaseHelper => DatabaseHelper();
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await databaseHelper.database;
    return _database!;
  }

  Future<void> insertProduct(Product product) async {
    final productMap = product.toMap();
    productMap.remove('id');
    final db = await database;
    await db.insert(
      'products',
      productMap,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> products() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    return List.generate(maps.length, (i) {
      return Product.fromMap(maps[i]);
    });
  }
}
