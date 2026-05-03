// lib/domain/failures/failures.dart

/// Base failure class for the application.
sealed class Failure {
  final String message;
  final Object? originalError;
  final StackTrace? stackTrace;

  const Failure({
    required this.message,
    this.originalError,
    this.stackTrace,
  });

  @override
  String toString() => 'Failure(message: $message)';
}

/// Failure that occurs when the DeepSeek API call fails.
class ApiFailure extends Failure {
  const ApiFailure({
    required super.message,
    super.originalError,
    super.stackTrace,
  });
}

/// Failure that occurs when parsing the DeepSeek JSON response fails.
class ParsingFailure extends Failure {
  const ParsingFailure({
    required super.message,
    super.originalError,
    super.stackTrace,
  });
}

/// Failure that occurs when a database operation fails.
class DatabaseFailure extends Failure {
  const DatabaseFailure({
    required super.message,
    super.originalError,
    super.stackTrace,
  });
}

/// Failure that occurs when the provided input is invalid.
class ValidationFailure extends Failure {
  const ValidationFailure({
    required super.message,
    super.originalError,
    super.stackTrace,
  });
}
