class GradeException implements Exception {
  final String msg;

  String toString() => msg;

  GradeException(this.msg);
}