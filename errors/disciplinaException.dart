class DisciplinaException implements Exception {
  final String msg;

  String toString() => msg;

  DisciplinaException(this.msg);
}