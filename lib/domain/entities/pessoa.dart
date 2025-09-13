class Pessoa {
  final int? id; // id opcional para permitir AUTOINCREMENT
  final String nome;
  final int idade;

  const Pessoa({this.id, required this.nome, required this.idade});

  Pessoa copyWith({int? id, String? nome, int? idade}) {
    return Pessoa(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      idade: idade ?? this.idade,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Pessoa &&
        other.id == id &&
        other.nome == nome &&
        other.idade == idade;
  }

  @override
  int get hashCode => Object.hash(id, nome, idade);

  @override
  String toString() => 'Pessoa(id: $id, nome: $nome, idade: $idade)';
}
