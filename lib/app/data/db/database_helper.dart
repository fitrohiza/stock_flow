import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_flow/app/data/db/tables/brand_table.dart';
import 'package:stock_flow/app/data/db/tables/customer_table.dart';
import 'package:stock_flow/app/data/db/tables/product_table.dart';
import 'package:stock_flow/app/data/db/tables/purchase_table.dart';

class DatabaseHelper {
  static Database? _db;
  static const _dbName = "app.db";

  static Future<Database> get db async {
    _db ??= await _initDb();
    return _db!;
  }

  static Future<Database> _initDb() async {
    final path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  static Future<void> _onCreate(Database db, int version) async {
    await db.execute(BrandTable.create);
    await db.execute(ProductTable.create);
    await db.execute(CustomerTable.create);
    await db.execute(PurchaseTable.create);
  }

  // =========================
  // 🔽 TAMBAHAN DI SINI
  // =========================

  Future<int> insert(String table, Map<String, dynamic> data) async {
    final database = await db;
    return await database.insert(table, data);
  }

  Future<List<Map<String, dynamic>>> getAll(String table) async {
    final database = await db;
    return await database.query(table);
  }

  Future<int> update(String table, Map<String, dynamic> data, int id) async {
    final database = await db;
    return await database.update(table, data, where: "id = ?", whereArgs: [id]);
  }

  Future<int> delete(String table, int id) async {
    final database = await db;
    return await database.delete(table, where: "id = ?", whereArgs: [id]);
  }
}
