import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:exemplo/domain/entities/pessoa.dart';
import 'package:exemplo/domain/usecases/add_pessoa.dart';
import '../mocks/pessoa_repository_mock.mocks.dart';



void main() {
  test('AddPessoa should validate and call repository', () async {
    final mockRepo = MockPessoaRepository();
    final usecase = AddPessoa(mockRepo);
    const pessoa = Pessoa(nome: 'João', idade: 30);

    when(mockRepo.addPessoa(pessoa)).thenAnswer((_) async => 1);

    final result = await usecase.call(pessoa);

    expect(result, equals(1));
    verify(mockRepo.addPessoa(pessoa)).called(1);
  });
}
