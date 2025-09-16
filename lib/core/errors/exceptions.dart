/// Exceções customizadas da aplicação
abstract class AppException implements Exception {
  final String message;
  final String? code;

  const AppException(this.message, {this.code});

  @override
  String toString() => 'AppException: $message';
}

/// Exceção para erros de banco de dados
class DatabaseException extends AppException {
  const DatabaseException(super.message, {super.code});

  @override
  String toString() => 'DatabaseException: $message';
}

/// Exceção para erros de validação
class ValidationException extends AppException {
  const ValidationException(super.message, {super.code});

  @override
  String toString() => 'ValidationException: $message';
}

/// Exceção para recursos não encontrados
class NotFoundException extends AppException {
  const NotFoundException(super.message, {super.code});

  @override
  String toString() => 'NotFoundException: $message';
}