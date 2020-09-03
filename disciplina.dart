import 'nota.dart';

class Disciplina {
  String _nome;
  int _qtdCreditos;
  Nota _nota;

  Disciplina(this._nome, this._qtdCreditos);

  String get nome => _nome;

  set definirNota(Nota nota) {
    this._nota = nota;
  }

  bool get estaAprovado {
    if (this._nota == null) {
      //LANÇAR ERRO
      return false;
    } else {
      return this._nota.estaAprovado;
    }
  }
}