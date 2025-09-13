import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'database_config.dart';

class DatabaseHelper {
  DatabaseHelper._internal();
  static final DatabaseHelper instance = DatabaseHelper._internal();

  Database? _db;

  Future<Database> get database async {
    _db ??= await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    if (kIsWeb) {
      return await databaseFactory.openDatabase(
        DatabaseConfig.dbName,
        options: OpenDatabaseOptions(
          version: DatabaseConfig.dbVersion,
          onCreate: _onCreate,
        ),
      );
    } else {
      final dbDir = await getDatabasesPath();
      final path = p.join(dbDir, DatabaseConfig.dbName);
      return await openDatabase(
        path,
        version: DatabaseConfig.dbVersion,
        onCreate: _onCreate,
      );
    }
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(DatabaseConfig.createPessoasTable);
  }

  Future<void> close() async {
    final db = _db;
    if (db != null) {
      await db.close();
      _db = null;
    }
  }
}
