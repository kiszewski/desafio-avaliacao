import 'errors/notaInvalidaException.dart';

class Nota {
  double _notaProva1;
  double _notaProva2;
  double _media;

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

  bool validarNota(nota) {
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
      return this._media * 2 - this._notaProva1;
    }
    if ((this._media != null) && (this._notaProva2 != null)) {
      return this._media * 2 - this._notaProva2;
    }
  }
}
