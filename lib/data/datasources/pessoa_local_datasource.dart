import 'package:sqflite/sqflite.dart';
import '../../core/database/database_helper.dart';
import '../../core/database/database_config.dart';
import '../models/pessoa_model.dart';

abstract class PessoaLocalDataSource {
  Future<int> insertPessoa(PessoaModel pessoa);
  Future<PessoaModel?> getPessoaById(int id);
  Future<List<PessoaModel>> getAllPessoas();
  Future<int> updatePessoa(PessoaModel pessoa);
  Future<int> deletePessoa(int id);
}

class PessoaLocalDataSourceImpl implements PessoaLocalDataSource {
  final DatabaseHelper _databaseHelper;

  PessoaLocalDataSourceImpl(this._databaseHelper);

  @override
  Future<int> insertPessoa(PessoaModel pessoa) async {
    final db = await _databaseHelper.database;
    return await db.insert(
      DatabaseConfig.tablePessoas,
      pessoa.toMap(),
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  @override
  Future<PessoaModel?> getPessoaById(int id) async {
    final db = await _databaseHelper.database;
    final result = await db.query(
      DatabaseConfig.tablePessoas,
      where: 'id = ?',
      whereArgs: [id],
      limit: 1,
    );

    if (result.isEmpty) return null;
    return PessoaModel.fromMap(result.first);
  }

  @override
  Future<List<PessoaModel>> getAllPessoas() async {
    final db = await _databaseHelper.database;
    final maps = await db.query(
      DatabaseConfig.tablePessoas,
      orderBy: 'id DESC',
    );

    return maps.map((m) => PessoaModel.fromMap(m)).toList();
  }

  @override
  Future<int> updatePessoa(PessoaModel pessoa) async {
    if (pessoa.id == null) return 0;
    final db = await _databaseHelper.database;
    return await db.update(
      DatabaseConfig.tablePessoas,
      pessoa.toMap(),
      where: 'id = ?',
      whereArgs: [pessoa.id],
    );
  }

  @override
  Future<int> deletePessoa(int id) async {
    final db = await _databaseHelper.database;
    return await db.delete(
      DatabaseConfig.tablePessoas,
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
