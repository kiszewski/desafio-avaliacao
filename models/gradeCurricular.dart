import 'disciplina.dart';

class GradeCurricular {
  List<Disciplina> _disciplinas;

  GradeCurricular(this._disciplinas);

  List<Disciplina> get disciplinas => this._disciplinas;

  List<Disciplina> get disciplinasComNotas =>
      _disciplinas.where((disciplina) => disciplina.temNota).toList();

  bool get aprovadoEmTodas =>
      disciplinasComNotas.every((disciplina) => disciplina.estaAprovado);

  int get qtdTotalCreditos => _disciplinas.fold(
      0, (previousValue, element) => previousValue + element.qtdCreditos);

  int get qtdCreditosConcluidos {
    List<Disciplina> disciplinasAprovadas = disciplinasComNotas
        .where((disciplina) => disciplina.estaAprovado == true)
        .toList();

    return disciplinasAprovadas.fold(
        0, (previousValue, element) => previousValue + element.qtdCreditos);
  }

  List<Disciplina> get disciplinasReprovadas => disciplinasComNotas
      .where((disciplina) => !disciplina.estaAprovado)
      .toList();
}
