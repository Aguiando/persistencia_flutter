import '../entities/pessoa.dart';
import '../repositories/pessoa_repository.dart';

class GetAllPessoas {
  final PessoaRepository repository;

  GetAllPessoas(this.repository);

  Future<List<Pessoa>> call() async {
    return await repository.getAllPessoas();
  }
}