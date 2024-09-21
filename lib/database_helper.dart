import 'package:addresses_app/address_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;
  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('addresses.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
    CREATE TABLE addresses (
      id INTEGER PRIMARY KEY,
      name TEXT NOT NULL,
      city TEXT NOT NULL,
      region TEXT NOT NULL,
      note TEXT
    )
    ''');
  }

  // add new address
  Future<int> insertAddress(AddressModel address) async {
    final db = await instance.database;
    return await db.insert('addresses', address.toMap());
  }

  // get all addresses
  Future<List<AddressModel>> getAllAddresses() async {
    final db = await instance.database;
    final result = await db.query('addresses');
    return result.map((map) => AddressModel.fromMap(map)).toList();
  }

  // update
  Future<int> updateAddress(AddressModel address) async {
    final db = await instance.database;
    return await db.update('addresses', address.toMap(),
        where: "id = ?", whereArgs: [address.id]);
  }

  // update
  Future<int> deleteAddress(int id) async {
    final db = await instance.database;
    return await db.delete('addresses', where: "id = ?", whereArgs: [id]);
  }
}
