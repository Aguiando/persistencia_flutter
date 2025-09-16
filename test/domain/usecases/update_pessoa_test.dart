import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:exemplo/domain/entities/pessoa.dart';
import 'package:exemplo/domain/usecases/update_pessoa.dart';
import '../mocks/pessoa_repository_mock.mocks.dart';


void main() {
  test('UpdatePessoa should require ID and call repository', () async {
    final mockRepo = MockPessoaRepository();
    final usecase = UpdatePessoa(mockRepo);
    const pessoa = Pessoa(id: 1, nome: 'João', idade: 30);
    
    when(mockRepo.updatePessoa(pessoa)).thenAnswer((_) async => 1);
    
    final result = await usecase.call(pessoa);
    
    expect(result, equals(1));
    verify(mockRepo.updatePessoa(pessoa)).called(1);
  });
}