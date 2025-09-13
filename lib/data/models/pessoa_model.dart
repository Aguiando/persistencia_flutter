import '../../domain/entities/pessoa.dart';

class PessoaModel extends Pessoa {
  const PessoaModel({super.id, required super.nome, required super.idade});

  factory PessoaModel.fromEntity(Pessoa pessoa) {
    return PessoaModel(id: pessoa.id, nome: pessoa.nome, idade: pessoa.idade);
  }

  factory PessoaModel.fromMap(Map<String, dynamic> map) {
    return PessoaModel(
      id: map['id'] as int?,
      nome: map['nome'] as String,
      idade: (map['idade'] as num).toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    final map = <String, dynamic>{'nome': nome, 'idade': idade};
    if (id != null) map['id'] = id;
    return map;
  }

  Pessoa toEntity() {
    return Pessoa(id: id, nome: nome, idade: idade);
  }
}
