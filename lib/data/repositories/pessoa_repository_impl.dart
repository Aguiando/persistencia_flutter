import '../../domain/entities/pessoa.dart';
import '../../domain/repositories/pessoa_repository.dart';
import '../datasources/pessoa_local_datasource.dart';
import '../models/pessoa_model.dart';

class PessoaRepositoryImpl implements PessoaRepository {
  final PessoaLocalDataSource _localDataSource;

  PessoaRepositoryImpl(this._localDataSource);

  @override
  Future<int> addPessoa(Pessoa pessoa) async {
    final pessoaModel = PessoaModel.fromEntity(pessoa);
    return await _localDataSource.insertPessoa(pessoaModel);
  }

  @override
  Future<Pessoa?> getPessoa(int id) async {
    final pessoaModel = await _localDataSource.getPessoaById(id);
    return pessoaModel?.toEntity();
  }

  @override
  Future<List<Pessoa>> getAllPessoas() async {
    final pessoasModel = await _localDataSource.getAllPessoas();
    return pessoasModel.map((model) => model.toEntity()).toList();
  }

  @override
  Future<int> updatePessoa(Pessoa pessoa) async {
    final pessoaModel = PessoaModel.fromEntity(pessoa);
    return await _localDataSource.updatePessoa(pessoaModel);
  }

  @override
  Future<int> deletePessoa(int id) async {
    return await _localDataSource.deletePessoa(id);
  }
}
