import 'package:flutter_test/flutter_test.dart';
import 'package:exemplo/data/models/pessoa_model.dart';
import 'package:exemplo/domain/entities/pessoa.dart';

void main() {
  test('PessoaModel should convert between entity and map', () {
    const pessoa = Pessoa(id: 1, nome: 'João', idade: 30);
    final model = PessoaModel.fromEntity(pessoa);
    final map = model.toMap();
    final modelFromMap = PessoaModel.fromMap(map);
    
    expect(model.toEntity(), equals(pessoa));
    expect(modelFromMap.id, equals(1));
    expect(map['nome'], equals('João'));
  });
}
