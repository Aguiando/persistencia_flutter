import 'package:get_it/get_it.dart';
import '../database/database_helper.dart';
import '../../data/datasources/pessoa_local_datasource.dart';
import '../../data/repositories/pessoa_repository_impl.dart';
import '../../domain/repositories/pessoa_repository.dart';
import '../../domain/usecases/add_pessoa.dart';
import '../../domain/usecases/get_all_pessoa.dart';
import '../../domain/usecases/update_pessoa.dart';
import '../../domain/usecases/delete_pessoa.dart';
import '../../presentation/viewmodels/pessoas_viewmodel.dart';

final GetIt serviceLocator = GetIt.instance;

/// Configuração de Dependency Injection
/// Registra todas as dependências da aplicação
Future<void> setupDependencyInjection() async {
  // Core - Database
  serviceLocator.registerLazySingleton<DatabaseHelper>(
    () => DatabaseHelper.instance,
  );

  // Data Layer - DataSources
  serviceLocator.registerLazySingleton<PessoaLocalDataSource>(
    () => PessoaLocalDataSourceImpl(serviceLocator<DatabaseHelper>()),
  );

  // Data Layer - Repositories
  serviceLocator.registerLazySingleton<PessoaRepository>(
    () => PessoaRepositoryImpl(serviceLocator<PessoaLocalDataSource>()),
  );

  // Domain Layer - Use Cases
  serviceLocator.registerLazySingleton<AddPessoa>(
    () => AddPessoa(serviceLocator<PessoaRepository>()),
  );

  serviceLocator.registerLazySingleton<GetAllPessoas>(
    () => GetAllPessoas(serviceLocator<PessoaRepository>()),
  );

  serviceLocator.registerLazySingleton<UpdatePessoa>(
    () => UpdatePessoa(serviceLocator<PessoaRepository>()),
  );

  serviceLocator.registerLazySingleton<DeletePessoa>(
    () => DeletePessoa(serviceLocator<PessoaRepository>()),
  );

  // Presentation Layer - ViewModels
  serviceLocator.registerFactory<PessoasViewModel>(
    () => PessoasViewModel(
      addPessoa: serviceLocator<AddPessoa>(),
      getAllPessoas: serviceLocator<GetAllPessoas>(),
      updatePessoa: serviceLocator<UpdatePessoa>(),
      deletePessoa: serviceLocator<DeletePessoa>(),
    ),
  );
}