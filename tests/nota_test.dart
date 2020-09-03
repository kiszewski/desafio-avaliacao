import 'package:test/test.dart';
import '../nota.dart';
import '../errors/notaInvalidaException.dart';

main() {
  test('Instanciar nota', () {
    Nota nota = Nota(nota1: 2, nota2: 8);
    expect(nota.mediaBrasileira, 5);
    expect(nota.estaAprovado, true);
    expect(nota.mediaAmericana, 'C');
  });

  test('Obter média somente com uma nota error', () {
    try {
      Nota nota = Nota(nota2: 3);
      nota.estaAprovado;
    } catch (e) {
      expect(e, isA<NotaInvalidaException>());
    }
  });

  test('Obter nota que não foi passada', () {
      Nota nota = Nota(nota2: 3, media: 6);
      expect(nota.notaFaltante, 9);
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
}
