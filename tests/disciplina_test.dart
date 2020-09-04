import 'package:test/test.dart';
import '../disciplina.dart';
import '../nota.dart';

main(List<String> args) {
  group('Testes na classe Disciplina', () {
    test('Aprovação na disciplina', () {
      Disciplina logMatematica = Disciplina('Logica Matematica', 4);
      logMatematica.definirNota(Nota.notaEUA(media: 'C'));
      expect(logMatematica.estaAprovado, true);

      Disciplina engSoftware = Disciplina('Engenharia de Software', 3);
      engSoftware.definirNota(Nota.notaEUA(nota1: 'D', nota2: 'D'));
      expect(engSoftware.estaAprovado, false);
    });

    test('Media na disciplina', () {
      Disciplina engSoftware = Disciplina('Engenharia de Software', 3);
      engSoftware.definirNota(Nota.notaEUA(media: 'C'));
      expect(engSoftware.mediaDisciplina, 6.9);   //Retornando sempre a nota mais alta possivel
    });
  });
}
