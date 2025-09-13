import '../entities/pessoa.dart';
import '../repositories/pessoa_repository.dart';

class AddPessoa {
  final PessoaRepository repository;

  AddPessoa(this.repository);

  Future<int> call(Pessoa pessoa) async {
    if (pessoa.nome.trim().length < 2) {
      throw ArgumentError('Nome deve ter pelo menos 2 caracteres');
    }

    if (pessoa.idade < 0 || pessoa.idade > 150) {
      throw ArgumentError('Idade deve estar entre 0 e 150 anos');
    }

    return await repository.addPessoa(pessoa);
  }
}