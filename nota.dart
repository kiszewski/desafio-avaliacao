import 'errors/notaInvalidaException.dart';

class Nota {
  double _notaProva1;
  double _notaProva2;
  double _media;
  List<Map<String, double>> _notasAmericanasValidas = [
    {'A': 9.5},
    {'B': 8.0},
    {'C': 6.0},
    {'D': 4.0},
    {'F': 1.0},
  ];

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
    if (validarNotaEUA(nota1)) {
      Map<String, double> notaSelecionada = _notasAmericanasValidas
          .firstWhere((element) => element.keys.toList()[0] == nota1);
      this._notaProva1 = notaSelecionada[nota1];
    }

    if (validarNotaEUA(nota2)) {
      Map<String, double> notaSelecionada = _notasAmericanasValidas
          .firstWhere((element) => element.keys.toList()[0] == nota2);
      this._notaProva2 = notaSelecionada[nota2];
    }

    if (validarNotaEUA(media)) {
      Map<String, double> notaSelecionada = _notasAmericanasValidas
          .firstWhere((element) => element.keys.toList()[0] == media);
      this._media = notaSelecionada[media];
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

      if (!this._notasAmericanasValidas.any((element) {
        String firstKey = element.keys.toList()[0];
        return nota == firstKey;
      })) {
        throw NotaInvalidaException(
            'Nota americana inválida, letras permitidas: A, B, C, D e F.');
      } else
        return true;
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
}
