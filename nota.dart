import 'errors/notaInvalidaException.dart';

class Nota {
  double _notaProva1;
  double _notaProva2;
  double _media;
  static const Map<String, List<double>> _notasAmericanasValidas = {
    'A': [9, 10],
    'B': [7, 8.9],
    'C': [5, 6.9],
    'D': [3, 4.9],
    'F': [0, 2.9],
  };

  Nota({double nota1, double nota2, double media}) {
    if (validarNota(nota1)) {
      this._notaProva1 = nota1;
    }

    if (validarNota(nota2)) {
      this._notaProva2 = nota2;
    }

    if (validarNota(media)) {
      this._media = media;
    }

    if ((this._notaProva1 != null) && (this._notaProva2 != null)) {
      this._media = (this._notaProva1 + this._notaProva2) / 2;
    }
  }

  Nota.notaEUA({String nota1, String nota2, String media}) {
    //Esse metódo pega a nota mais alta. Ex:
    //Se o aluno tirou A, a nota brasileira dele vai ser 10

    if (validarNotaEUA(nota1)) {
      String notaSelecionada =
          letrasAmericanas.firstWhere((key) => key == nota1);
      this._notaProva1 = Nota._notasAmericanasValidas[notaSelecionada][1];
    }

    if (validarNotaEUA(nota2)) {
      String notaSelecionada =
          letrasAmericanas.firstWhere((key) => key == nota2);
      this._notaProva2 = Nota._notasAmericanasValidas[notaSelecionada][1];
    }

    if (validarNotaEUA(media)) {
      String notaSelecionada =
          letrasAmericanas.firstWhere((key) => key == media);
      this._media = Nota._notasAmericanasValidas[notaSelecionada][1];
    }

    if ((this._notaProva1 != null) && (this._notaProva2 != null)) {
      this._media = (this._notaProva1 + this._notaProva2) / 2;
    }
  }

  bool validarNota(double nota) {
    if (nota != null) {
      if (nota > 10) {
        throw NotaInvalidaException('Nota acima do limite.');
      } else if (nota < 0) {
        throw NotaInvalidaException('Nota abaixo do limite.');
      }
      return true;
    }
    return false;
  }

  bool validarNotaEUA(String nota) {
    if (nota != null) {
      if (nota.length > 1) {
        throw NotaInvalidaException(
            'Nota americana inválida, permitido somente uma letra.');
      }

      if (letrasAmericanas.any((letra) => nota == letra)) {
        return true;
      } else {
        throw NotaInvalidaException(
            'Nota americana inválida, letras permitidas: A, B, C, D e F.');
      }
    }
    return false;
  }

  bool get estaAprovado {
    if (this._media != null) {
      return this._media >= 5 ? true : false;
    }

    throw NotaInvalidaException('Sem dados suficientes para calcular média.');
  }

  double get mediaBrasileira {
    if (this._media != null) {
      return this._media;
    }

    throw NotaInvalidaException('Sem dados suficientes para calcular média.');
  }

  String get mediaAmericana {
    if (this._media != null) {
      if (this._media >= 9) {
        return 'A';
      } else if (this._media >= 7) {
        return 'B';
      } else if (this._media >= 5) {
        return 'C';
      } else if (this._media >= 3) {
        return 'D';
      } else
        return 'F';
    }

    throw NotaInvalidaException('Sem dados suficientes para calcular média.');
  }

  double get notaFaltante {
    if (this._media == null) {
      throw NotaInvalidaException('Sem média para calcular nota restante.');
    }

    if ((this._media != null) && (this._notaProva1 != null)) {
      double notaProva2 = this._media * 2 - this._notaProva1;

      return notaProva2 > 10
          ? throw NotaInvalidaException(
              'Média incopampatível com a nota passada.')
          : notaProva2;
    }

    if ((this._media != null) && (this._notaProva2 != null)) {
      double notaProva1 = this._media * 2 - this._notaProva2;

      return notaProva1 > 10
          ? throw NotaInvalidaException(
              'Média incopampatível com a nota passada.')
          : notaProva1;
    }
  }

  List<String> get letrasAmericanas =>
      Nota._notasAmericanasValidas.keys.toList();

  double notaNecessaria(String notaDesejada) {
    if (validarNotaEUA(notaDesejada)) {
      final double mediaDesejada = Nota._notasAmericanasValidas[notaDesejada][0];
      if (this._notaProva1 != null) {
        return (mediaDesejada * 2) - this._notaProva1;
      } else if (this._notaProva2 != null) {
        return (mediaDesejada * 2) - this._notaProva2;
      } else {
        throw NotaInvalidaException('Sem nota para calcular nota necessária.');
      }
    } else {
      throw NotaInvalidaException('Nota inválida.');
    }
  }
}
