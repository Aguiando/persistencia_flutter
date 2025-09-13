import '../entities/pessoa.dart';

/// Interface do repositório - Define contratos para acesso aos dados
abstract class PessoaRepository {
  Future<int> addPessoa(Pessoa pessoa);
  Future<Pessoa?> getPessoa(int id);
  Future<List<Pessoa>> getAllPessoas();
  Future<int> updatePessoa(Pessoa pessoa);
  Future<int> deletePessoa(int id);
}