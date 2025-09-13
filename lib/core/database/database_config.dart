class DatabaseConfig {
  static const String dbName = 'meu_banco.db';
  static const String tablePessoas = 'pessoas';
  static const int dbVersion = 1;

  static const String createPessoasTable =
      '''
    CREATE TABLE $tablePessoas(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL,
      idade INTEGER NOT NULL
    )
  ''';
}
