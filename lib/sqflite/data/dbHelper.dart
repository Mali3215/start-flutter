import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../models/product.dart';

class DBHelper {
  Database? _db;

  Future<Database> get db async {
    if (_db == null) {
      _db = await initializeDB();
    }
    return _db!;
  }

  Future<Database> initializeDB() async {
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDB = await openDatabase(dbPath, version: 1, onCreate: createDB);
    return eTradeDB;
  }

  void createDB(Database db, int version) async {
    await db.execute(
        "CREATE TABLE products(id INTEGER PRIMARY KEY, name TEXT, description TEXT, unitPrice INTEGER)");
  }

  Future<List<Product>> getProducts() async {
    Database db = await this.db;
    var result = await db.query("products");

    return List.generate(result.length, (index) {
      return Product.fromObject(result[index]);
    });
  }

  Future<int> addProduct(Product product) async {
    Database db = await this.db;
    var result = await db.insert("products", product.toMap());
    return result;
  }

  Future<int> deleteProduct(int id) async {
    Database db = await this.db;
    var result = await db.rawDelete("DELETE FROM products WHERE id=$id");
    return result;
  }

  Future<int> updateProduct(Product product) async {
    Database db = await this.db;
    var result = await db.update("products", product.toMap(),
        where: "id=?", whereArgs: [product.id]);
    return result;
  }
}
