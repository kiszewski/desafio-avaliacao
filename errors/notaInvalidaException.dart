class NotaInvalidaException implements Exception {
  final String msg;

  String toString() => msg;

  NotaInvalidaException(this.msg);
}