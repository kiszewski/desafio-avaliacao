import 'disciplina.dart';

class GradeCurricular {
  List<Disciplina> _disciplinas;

  GradeCurricular(this._disciplinas);

  bool get aprovadoEmTodas {
    //Percorrer _disciplinas;
  }

  List<String> get nomesDisciplinas {
    return this._disciplinas.map((disciplina) {
      return disciplina.nome;
    }).toList();
  }

  List<Disciplina> get disciplinas => this._disciplinas;
}