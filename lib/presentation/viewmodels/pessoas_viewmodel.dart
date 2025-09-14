
import '../../core/database/database_helper.dart';
import '../../data/datasources/pessoa_local_datasource.dart';
import '../../data/repositories/pessoa_repository_impl.dart';
import '../../domain/entities/pessoa.dart';

class DatabaseHelperAdapter {
  static final DatabaseHelperAdapter instance =
      DatabaseHelperAdapter._internal();
  DatabaseHelperAdapter._internal();

  late final PessoaRepositoryImpl _repository;

  void initialize() {
    final dataSource = PessoaLocalDataSourceImpl(DatabaseHelper.instance);
    _repository = PessoaRepositoryImpl(dataSource);
  }

  // Métodos que mantêm a interface antiga
  Future<int> insert(Pessoa p) => _repository.addPessoa(p);
  Future<Pessoa?> getById(int id) => _repository.getPessoa(id);
  Future<List<Pessoa>> getAll() => _repository.getAllPessoas();
  Future<int> update(Pessoa p) => _repository.updatePessoa(p);
  Future<int> delete(int id) => _repository.deletePessoa(id);
}
