import 'package:test/test.dart';
import '../models/disciplina.dart';
import '../models/nota.dart';

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
      //Quando for passado somente a media, sera atribuido o valor
      // entre a nota nota mais alta e a nota mais baixa, C = 5-6.9
      expect(engSoftware.mediaDisciplina.toStringAsFixed(1), '6.0');   
    });
  });
}
