import 'models/disciplina.dart';
import 'models/gradeCurricular.dart';
import 'models/nota.dart';

class ProcessarFrases {
  final GradeCurricular _grade = GradeCurricular([
    Disciplina('Logica Matematica', 4),
    Disciplina('Engenharia de Software', 6),
    Disciplina('Teoria da computacao', 3),
    Disciplina('Banco de Dados', 6),
    Disciplina('Arquitetura de Software', 4),
  ]);

  List<String> respostas = [];

  ProcessarFrases(List<String> txt) {
    if (txt.isNotEmpty) {
      //Separar o que é pergunta e o que é frase
      List<String> instrucoes =
          txt.where((element) => !element.endsWith('?')).toList();
      List<String> perguntas =
          txt.where((element) => element.endsWith('?')).toList();

      _processarNotas(instrucoes);
      _processarPerguntas(perguntas);
    }
  }
  
  _processarNotas(List<String> instrucoes) {
    //Palavras Chaves ou PC:
    const String PC_MEDIA = 'media';
    const String PC_PROVA1 = 'prova1';
    const String PC_PROVA2 = 'prova2';

    for (var frase in instrucoes) {
      frase = frase.toLowerCase();

      for (var disciplina in this._grade.disciplinas) {
        try {
          if (frase.startsWith(disciplina.nome.toLowerCase())) {
            final String notaLetra = frase[frase.length - 1].toUpperCase();

            if (frase.contains(PC_MEDIA)) {
              if (disciplina.temNota) {
                Nota notaExistente = disciplina.obterNota;
                notaExistente.inserirMedia(notaLetra);
              } else {
                disciplina.definirNota(Nota.notaEUA(media: notaLetra));
              }
            }

            if (frase.contains(PC_PROVA1)) {
              if (disciplina.temNota) {
                Nota notaExistente = disciplina.obterNota;
                notaExistente.inserirNota1(notaLetra);
              } else {
                disciplina.definirNota(Nota.notaEUA(nota1: notaLetra));
              }
            }

            if (frase.contains(PC_PROVA2)) {
              if (disciplina.temNota) {
                Nota notaExistente = disciplina.obterNota;
                notaExistente.inserirNota2(notaLetra);
              } else {
                disciplina.definirNota(Nota.notaEUA(nota2: notaLetra));
              }
            }
          }
        } catch (e) {
          this.respostas.add(e.toString());
        }
      }
    }
  }

  _processarPerguntas(List<String> perguntas) {
    //Palavras Chaves ou PC:
    const String PC_MEDIA = 'media';
    const String PC_PROVA1 = 'prova1';
    const String PC_PROVA2 = 'prova2';
    const String PC_APROVADO = 'aprovado';
    const String PC_TODAS_DISCIPLINAS = 'todas as disciplinas';
    const String PC_CREDITOS = 'quantos creditos';
    const String PC_CURSOU = 'cursou';
    const String PC_CONCLUIU = 'concluiu';
    const String PC_SEMESTRE = 'semestre';
    const String PC_QUAL_NOTA = 'qual a nota';
    const String PC_NECESSARIA = 'preciso tirar em';
    const String PC_PARA_PASSAR = 'para passar';
    const String PC_PARA_FICAR = 'para ficar com media';

    String fraseResposta;

    for (var pergunta in perguntas) {
      pergunta = pergunta.toLowerCase();

      if (pergunta.contains(PC_MEDIA)) {
        fraseResposta = _qualMedia(pergunta);
      }

      if (pergunta.contains(PC_APROVADO) &&
          pergunta.contains(PC_TODAS_DISCIPLINAS)) {
        fraseResposta = _aprovadoEmTodasDisciplinas(pergunta);
      } else if (pergunta.contains(PC_APROVADO)) {
        fraseResposta = _aprovadoNaDisciplina(pergunta);
      }

      if (pergunta.startsWith(PC_CREDITOS) &&
          pergunta.contains(PC_CURSOU) &&
          pergunta.contains(PC_SEMESTRE)) {
        fraseResposta = _quantosCreditosCursados(pergunta);
      } else if (pergunta.startsWith(PC_CREDITOS) &&
          pergunta.contains(PC_CONCLUIU)) {
        fraseResposta = _quantosCreditosAprovados(pergunta);
      }

      if (pergunta.startsWith(PC_QUAL_NOTA) &&
          pergunta.contains(PC_NECESSARIA) &&
          pergunta.contains(PC_PARA_PASSAR)) {
        fraseResposta = __qualNotaNecessariaParaPassar(pergunta);
      } else if (pergunta.startsWith(PC_QUAL_NOTA) &&
          pergunta.contains(PC_PROVA1)) {
        fraseResposta = _qualNotaProva(pergunta, 'Prova1');
      } else if (pergunta.startsWith(PC_QUAL_NOTA) &&
          pergunta.contains(PC_PROVA2)) {
        fraseResposta = _qualNotaProva(pergunta, 'Prova2');
      }

      if (pergunta.startsWith(PC_PARA_FICAR)) {
        fraseResposta = _qualNotaNecessaria(pergunta);
      }

      fraseResposta == null ?
        this.respostas.add('Nem ideia do que isso significa') :
        this.respostas.add(fraseResposta);
        
      fraseResposta = null;
    }
  }

  String _qualMedia(String pergunta) {
    String resposta;

    for (var disciplina in this._grade.disciplinas) {
      if (pergunta.endsWith('${disciplina.nome.toLowerCase()}?')) {
        try {
          double media = disciplina.mediaDisciplina;
          resposta =
              'A media em ${disciplina.nome} foi de ${media.toStringAsFixed(1)}';
        } catch (e) {
          resposta = e.toString();
        } finally {
          return resposta;
        }
      }
    }
  }

  String _aprovadoEmTodasDisciplinas(String pergunta) {
    String resposta;
    // Se o aluno foi aprovado em todas as disciplinas
    // Esse metodo considera somente as disciplinas com notas
    // Se o aluno for reprovado em mais de uma prova só sera exibido uma das notas que ele rodou
    try {
      resposta = this._grade.aprovadoEmTodas
          ? 'Sim, fui aprovado em todas disciplinas'
          : 'Não, reprovei em ${_grade.disciplinasReprovadas[0].nome}';
    } catch (e) {
      resposta = e.toString();
    } finally {
      return resposta;
    }
  }

  String _aprovadoNaDisciplina(String pergunta) {
    // Se o aluno foi aprovado em uma disciplina especifica
    String resposta;
    for (var disciplina in this._grade.disciplinasComNotas) {
      if (pergunta.contains(disciplina.nome.toLowerCase())) {
        try {
          resposta = disciplina.estaAprovado
              ? 'Sim, fui aprovado em ${disciplina.nome} com media ${disciplina.mediaDisciplina.toStringAsFixed(1)}'
              : 'Não, fui reprovado em ${disciplina.nome} com media ${disciplina.mediaDisciplina.toStringAsFixed(1)}';
        } catch (e) {
          resposta = e.toString();
        } finally {
          return resposta;
        }
      }
    }
  }

  String _quantosCreditosCursados(String pergunta) {
    // Quantos creditos o aluno cursou no semestre
    String resposta;
    try {
      String qtdCreditos = this._grade.qtdTotalCreditos.toString();
      resposta = 'No semestre cursei $qtdCreditos creditos';
    } catch (e) {
      resposta = e.toString();
    } finally {
      return resposta;
    }
  }

  String _quantosCreditosAprovados(String pergunta) {
    // Quantos creditos o aluno foi aprovado no semestre
    String resposta;
    try {
      String qtdCreditos = this._grade.qtdCreditosConcluidos.toString();
      resposta = 'Conclui $qtdCreditos creditos';
    } catch (e) {
      resposta = e.toString();
    } finally {
      return resposta;
    }
  }

  String __qualNotaNecessariaParaPassar(String pergunta) {
    String resposta;
    for (var disciplina in this._grade.disciplinasComNotas) {
      if (pergunta.contains(disciplina.nome.toLowerCase())) {
        try {
          final Nota nota = disciplina.obterNota;
          String notaNecessaria = nota.notaNecessaria('C').toStringAsFixed(1);
          resposta = 'A nota em ${disciplina.nome} deve ser $notaNecessaria';
        } catch (e) {
          resposta = e.toString();
        } finally {
          return resposta;
        }
      }
    }
  }

  String _qualNotaProva(String pergunta, String prova) {
    String resposta;
    for (var disciplina in this._grade.disciplinasComNotas) {
      if (pergunta.contains(disciplina.nome.toLowerCase())) {
        try {
          Nota nota = disciplina.obterNota;
          String notaFaltante = nota.notaFaltante.toStringAsFixed(1);
          resposta = 'A nota da $prova em ${disciplina.nome} foi $notaFaltante';
        } catch (e) {
          resposta = e.toString();
        } finally {
          return resposta;
        }
      }
    }
  }

  String _qualNotaNecessaria(String pergunta) {
    String resposta;
    String provaDesejada = pergunta.contains('prova1') ? 'Prova1' : 'Prova2';

    for (var disciplina in this._grade.disciplinas) {
      if (pergunta.contains(disciplina.nome.toLowerCase())) {
        try {
          String notaDesejada = pergunta[21].toUpperCase();
          Nota nota = disciplina.obterNota;
          String notaNecessaria =
              nota.notaNecessaria(notaDesejada).toStringAsFixed(1);
          resposta =
              'A nota da $provaDesejada em ${disciplina.nome} deve ser $notaNecessaria';
        } catch (e) {
          resposta = e.toString();
        } finally {
          return resposta;
        }
      }
    }
  }

  GradeCurricular get grade => this._grade;
}
