class ExceptionEntity implements Exception {
  static const String unknownError = 'server_error_unknown_error';
  final String code;
  final String message;

  ExceptionEntity({this.code = unknownError, this.message = unknownError});

  @override
  String toString() {
    return 'ExceptionEntity{code: $code, message: $message}';
  }

  factory ExceptionEntity.fromException(dynamic e) {
    if (e is ExceptionEntity) {
      return e;
    } else {
      return ExceptionEntity();
    }
  }
}
