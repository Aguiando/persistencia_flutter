import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:exemplo/domain/entities/pessoa.dart';
import 'package:exemplo/domain/usecases/get_all_pessoa.dart';
import '../mocks/pessoa_repository_mock.mocks.dart';

void main() {
  test('GetAllPessoas should return list from repository', () async {
    final mockRepo = MockPessoaRepository();
    final usecase = GetAllPessoas(mockRepo);
    const pessoas = [Pessoa(id: 1, nome: 'João', idade: 30)];
    
    when(mockRepo.getAllPessoas()).thenAnswer((_) async => pessoas);
    
    final result = await usecase.call();
    
    expect(result, equals(pessoas));
    verify(mockRepo.getAllPessoas()).called(1);
  });
}