import 'disciplina.dart';
import '../errors/gradeException.dart';

class GradeCurricular {
  List<Disciplina> _disciplinas;

  GradeCurricular(this._disciplinas);

  bool get aprovadoEmTodas {
    return disciplinasComNotas.every((disciplina) => disciplina.estaAprovado);
  }
  
  int get qtdTotalCreditos =>
    _disciplinas.fold(0, (previousValue, element) => previousValue + element.qtdCreditos);

  int get qtdCreditosConcluidos {
    List<Disciplina> disciplinasAprovadas = disciplinasComNotas.where((disciplina) => disciplina.estaAprovado == true).toList();

    return disciplinasAprovadas
      .fold(0, (previousValue, element) => previousValue + element.qtdCreditos);
  }

  List<Disciplina> get disciplinasComNotas => _disciplinas.where((disciplina) => disciplina.temNota).toList();

  List<String> get nomesDisciplinas {
    return this._disciplinas.map((disciplina) {
      return disciplina.nome;
    }).toList();
  }

  List<Disciplina> get disciplinas => this._disciplinas;
}