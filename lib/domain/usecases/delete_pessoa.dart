import '../repositories/pessoa_repository.dart';

class DeletePessoa {
  final PessoaRepository repository;

  DeletePessoa(this.repository);

  Future<int> call(int id) async {
    if (id <= 0) {
      throw ArgumentError('ID deve ser maior que zero');
    }

    return await repository.deletePessoa(id);
  }
}