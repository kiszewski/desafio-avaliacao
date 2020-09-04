import 'package:test/test.dart';
import '../models/disciplina.dart';
import '../models/nota.dart';
import '../models/gradeCurricular.dart';

main(List<String> args) {
  Disciplina engSoftware = Disciplina('Engenharia de Software', 3);
  Disciplina logMatematica = Disciplina('Logica Matematica', 4);
  logMatematica.definirNota(Nota.notaEUA(media: 'C'));
  engSoftware.definirNota(Nota.notaEUA(nota1: 'A', nota2: 'C'));

  GradeCurricular grade = GradeCurricular([engSoftware, logMatematica]);

  group('Testes na classe gradeCurricular', () {
    test('Aprovado em todas disciplinas', () {
      expect(grade.aprovadoEmTodas, true);

      //Adicionando uma materia reprovada
      Disciplina bancoDeDados = Disciplina('Banco de dados', 7);
      bancoDeDados.definirNota(Nota.notaEUA(media: 'F'));
      grade.disciplinas.add(bancoDeDados);
      
      expect(grade.aprovadoEmTodas, false);
    });

    test('Quantidade Total de creditos', () {
      expect(grade.qtdTotalCreditos, 14);
    });

    test('Quantidade de creditos em disciplinas aprovadas', () {
      expect(grade.qtdCreditosConcluidos, 7);
    });
  });
}
