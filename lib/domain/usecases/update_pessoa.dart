import '../entities/pessoa.dart';
import '../repositories/pessoa_repository.dart';

class UpdatePessoa {
  final PessoaRepository repository;

  UpdatePessoa(this.repository);

  Future<int> call(Pessoa pessoa) async {
    if (pessoa.id == null) {
      throw ArgumentError('ID é obrigatório para atualização');
    }

    if (pessoa.nome.trim().length < 2) {
      throw ArgumentError('Nome deve ter pelo menos 2 caracteres');
    }

    if (pessoa.idade < 0 || pessoa.idade > 150) {
      throw ArgumentError('Idade deve estar entre 0 e 150 anos');
    }

    return await repository.updatePessoa(pessoa);
  }
}