import 'package:test/test.dart';
import '../models/gradeCurricular.dart';
import '../models/nota.dart';
import '../index.dart';

main() {
  test('Inserir dados', () {
      final List<String> frases = [
    'Teoria da computacao prova1 F',
    'Teoria da computacao prova2 D',
  ];

  GradeCurricular grade = processarNotas(frases);
  Nota n1 = grade.disciplinasComNotas[0].obterNota;

  expect(grade.disciplinasComNotas.length, 1);
  expect(grade.aprovadoEmTodas, false);
  });

  final List<String> frases = [
    'Logica Matematica media C',
    'Engenharia de Software prova1 A',
    'Engenharia de Software prova2 B',
    'Banco de Dados media B',
    'Teoria da computacao prova1 F',
    'Teoria da computacao prova2 D',
  ];
  test('Inserir dados atraves das frases', () {
    GradeCurricular grade = processarNotas(frases);

    expect(grade.aprovadoEmTodas, false);
  });
}
