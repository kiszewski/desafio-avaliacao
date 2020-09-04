import 'package:test/test.dart';
import '../nota.dart';
import '../errors/notaInvalidaException.dart';

main() {
  group('Testes da classe Nota', () {
    test('Instanciar nota', () {
      Nota nota = Nota(nota1: 2, nota2: 8);
      expect(nota.mediaBrasileira, 5);
      expect(nota.estaAprovado, true);
      expect(nota.mediaAmericana, 'C');
    });

    test('Obter nota que não foi passada', () {
      Nota nota = Nota(nota2: 3, media: 6);
      expect(nota.notaFaltante, 9);
    });

    test('Validar nota Americana', () {
      Nota nota = Nota.notaEUA(nota1: 'A', nota2: 'C');
      expect(nota.estaAprovado, true);
      expect(nota.mediaAmericana, 'B');

      Nota nota2 = Nota.notaEUA(nota1: 'D', nota2: 'D');
      expect(nota2.estaAprovado, false);
      expect(nota2.mediaAmericana, 'D');

      Nota nota3 = Nota.notaEUA(nota1: 'F', nota2: 'F');
      expect(nota3.estaAprovado, false);
      expect(nota3.mediaAmericana, 'F');

      Nota nota4 = Nota.notaEUA(media: 'C');
      expect(nota4.estaAprovado, true);
      expect(nota4.mediaAmericana, 'C');
    });

    test('Obter nota desejada', () {
      Nota nota = Nota.notaEUA(nota1: 'C');
      expect(nota.notaNecessaria('B'), 7.1);
    });

    test('Validar nota Americana error', () {
      try {
        Nota nota = Nota.notaEUA(nota1: 'X');
      } catch (e) {
        expect(e, isA<NotaInvalidaException>());
      }

      try {
        Nota nota = Nota.notaEUA(media: 'E');
      } catch (e) {
        expect(e, isA<NotaInvalidaException>());
      }
    });

    test('Obter média somente com uma nota error', () {
      try {
        Nota nota = Nota(nota2: 3);
        nota.estaAprovado;
      } catch (e) {
        expect(e, isA<NotaInvalidaException>());
      }
    });

    test('Obter nota faltante error', () {
      try {
        Nota nota = Nota(nota2: 0.5, media: 9.5);
        nota.notaFaltante;
      } catch (e) {
        expect(e, isA<NotaInvalidaException>());
      }
    });

    test('Instanciar nota error', () {
      try {
        Nota nota = Nota(media: -2);
      } catch (e) {
        expect(e, isA<NotaInvalidaException>());
      }

      try {
        Nota nota = Nota(nota1: 11);
      } catch (e) {
        expect(e, isA<NotaInvalidaException>());
      }
    });
  });
}
