import 'package:flutter_test/flutter_test.dart';
import 'package:exemplo/domain/entities/pessoa.dart';

void main() {
  test('Pessoa entity should create and compare correctly', () {
    const pessoa1 = Pessoa(id: 1, nome: 'João', idade: 30);
    const pessoa2 = Pessoa(id: 1, nome: 'João', idade: 30);
    
    expect(pessoa1, equals(pessoa2));
    expect(pessoa1.toString(), contains('João'));
  });
}