import 'nota.dart';
import '../errors/disciplinaException.dart';

class Disciplina {
  String _nome;
  int _qtdCreditos;
  Nota _nota;

  Disciplina(this._nome, this._qtdCreditos);

  String get nome => _nome;
  int get qtdCreditos => this._qtdCreditos;
  Nota get obterNota => this._nota;
  bool get temNota => this._nota == null ? false : true;

  definirNota(Nota nota) => this._nota = nota;

  bool get estaAprovado {
    if (this._nota == null) {
      throw DisciplinaException('Sem nota para avaliar.');
    } else {
      return this._nota.estaAprovado;
    }
  }

  double get mediaDisciplina {
    if (this._nota == null) {
      throw DisciplinaException('Sem nota para avaliar.');
    } else {
      return this._nota.mediaBrasileira;
    }
  }
}
