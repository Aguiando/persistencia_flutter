import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'package:exemplo/domain/usecases/delete_pessoa.dart';
import '../mocks/pessoa_repository_mock.mocks.dart';


void main() {
  test('DeletePessoa should validate ID and call repository', () async {
    final mockRepo = MockPessoaRepository();
    final usecase = DeletePessoa(mockRepo);
    
    when(mockRepo.deletePessoa(1)).thenAnswer((_) async => 1);
    
    final result = await usecase.call(1);
    
    expect(result, equals(1));
    verify(mockRepo.deletePessoa(1)).called(1);
  });
}