import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:exemplo/domain/entities/pessoa.dart';
import 'package:exemplo/data/datasources/pessoa_local_datasource.dart';
import 'package:exemplo/data/repositories/pessoa_repository_impl.dart';

@GenerateMocks([PessoaLocalDataSource])
import 'pessoa_repository_impl_test.mocks.dart';

void main() {
  test('PessoaRepositoryImpl should delegate to datasource', () async {
    final mockDataSource = MockPessoaLocalDataSource();
    final repository = PessoaRepositoryImpl(mockDataSource);
    const pessoa = Pessoa(nome: 'João', idade: 30);
    
    when(mockDataSource.insertPessoa(any)).thenAnswer((_) async => 1);
    
    final result = await repository.addPessoa(pessoa);
    
    expect(result, equals(1));
    verify(mockDataSource.insertPessoa(any)).called(1);
  });
}