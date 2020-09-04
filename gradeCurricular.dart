import 'disciplina.dart';
import './errors/gradeException.dart';

class GradeCurricular {
  List<Disciplina> _disciplinas;

  GradeCurricular(this._disciplinas);

  bool get aprovadoEmTodas =>
    _disciplinas.every((disciplina) => disciplina.estaAprovado);
  
  int get qtdTotalCreditos =>
    _disciplinas.fold(0, (previousValue, element) => previousValue + element.qtdCreditos);

  int get qtdCreditosConcluidos {
    List<Disciplina> disciplinasAprovadas = _disciplinas.where((disciplina) => disciplina.estaAprovado == true).toList();

    return disciplinasAprovadas
      .fold(0, (previousValue, element) => previousValue + element.qtdCreditos);
  }

  List<String> get nomesDisciplinas {
    return this._disciplinas.map((disciplina) {
      return disciplina.nome;
    }).toList();
  }

  List<Disciplina> get disciplinas => this._disciplinas;
}