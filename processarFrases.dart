import 'models/disciplina.dart';
import 'models/gradeCurricular.dart';
import 'models/nota.dart';

class ProcessarFrases {
  final GradeCurricular grade = GradeCurricular([
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

      processarNotas(instrucoes);
      processarPerguntas(perguntas);
    }
  }

  processarNotas(List<String> instrucoes) {
    //Palavras Chaves ou PC:
    const String PC_MEDIA = 'media';
    const String PC_PROVA1 = 'prova1';
    const String PC_PROVA2 = 'prova2';

    for (var frase in instrucoes) {
      frase = frase.toLowerCase();

      for (var disciplina in this.grade.disciplinas) {
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

  processarPerguntas(List<String> perguntas) {
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
        for (var disciplina in this.grade.disciplinas) {
          if (pergunta.endsWith('${disciplina.nome.toLowerCase()}?')) {
            //Qual a media dessa disciplina:
            try {
              double media = disciplina.mediaDisciplina;
              fraseResposta =
                  'A media em ${disciplina.nome} foi de ${media.toStringAsFixed(1)}';
            } catch (e) {
              fraseResposta = e.toString();
            }
          }
        }
      }

      if (pergunta.contains(PC_APROVADO) &&
          pergunta.contains(PC_TODAS_DISCIPLINAS)) {
        // Se o aluno foi aprovado em todas as disciplinas
        // Esse metodo considera somente as disciplinas com notas
        // Se o aluno for reprovado em mais de uma prova só sera exibido uma das notas que ele rodou
        try {
          fraseResposta = grade.aprovadoEmTodas
              ? 'Sim, fui aprovado em todas disciplinas'
              : 'Não, reprovei em ${grade.disciplinasReprovadas[0].nome}';
        } catch (e) {
          fraseResposta = e.toString();
        }
      } else if (pergunta.contains(PC_APROVADO)) {
        // Se o aluno foi aprovado em uma disciplina especifica
        for (var disciplina in grade.disciplinasComNotas) {
          if (pergunta.contains(disciplina.nome.toLowerCase())) {
            try {
              fraseResposta = disciplina.estaAprovado
                  ? 'Sim, fui aprovado em ${disciplina.nome} com media ${disciplina.mediaDisciplina.toStringAsFixed(1)}'
                  : 'Não, fui reprovado em ${disciplina.nome} com media ${disciplina.mediaDisciplina.toStringAsFixed(1)}';
            } catch (e) {
              fraseResposta = e.toString();
            }
          }
        }
      }

      if (pergunta.startsWith(PC_CREDITOS) &&
          pergunta.contains(PC_CURSOU) &&
          pergunta.contains(PC_SEMESTRE)) {
        // Quantos creditos o aluno cursou no semestre
        try {
          String qtdCreditos = grade.qtdTotalCreditos.toString();
          fraseResposta = 'No semestre cursei $qtdCreditos creditos';
        } catch (e) {
          fraseResposta = e.toString();
        }
      } else if (pergunta.startsWith(PC_CREDITOS) &&
          pergunta.contains(PC_CONCLUIU)) {
        // Quantos creditos o aluno foi aprovado no semestre
        try {
          String qtdCreditos = grade.qtdCreditosConcluidos.toString();
          fraseResposta = 'Conclui $qtdCreditos creditos';
        } catch (e) {
          fraseResposta = e.toString();
        }
      }

      if (pergunta.startsWith(PC_QUAL_NOTA) &&
          pergunta.contains(PC_NECESSARIA) &&
          pergunta.contains(PC_PARA_PASSAR)) {
        for (var disciplina in grade.disciplinasComNotas) {
          if (pergunta.contains(disciplina.nome.toLowerCase())) {
            final Nota nota = disciplina.obterNota;
            String notaNecessaria = nota.notaNecessaria('C').toStringAsFixed(1);
            fraseResposta =
                'A nota em ${disciplina.nome} deve ser $notaNecessaria';
          }
        }
      } else if (pergunta.startsWith(PC_QUAL_NOTA) &&
          pergunta.contains(PC_PROVA1)) {
        for (var disciplina in grade.disciplinasComNotas) {
          if (pergunta.contains(disciplina.nome.toLowerCase())) {
            try {
              Nota nota = disciplina.obterNota;
              String notaFaltante = nota.notaFaltante.toStringAsFixed(1);
              fraseResposta =
                  'A nota da Prova1 em ${disciplina.nome} foi $notaFaltante';
            } catch (e) {
              fraseResposta = e.toString();
            }
          }
        }
      } else if (pergunta.startsWith(PC_QUAL_NOTA) &&
          pergunta.contains(PC_PROVA2)) {
        for (var disciplina in grade.disciplinasComNotas) {
          if (pergunta.contains(disciplina.nome.toLowerCase())) {
            try {
              Nota nota = disciplina.obterNota;
              String notaFaltante = nota.notaFaltante.toStringAsFixed(1);
              fraseResposta =
                  'A nota da Prova2 em ${disciplina.nome} foi $notaFaltante';
            } catch (e) {
              fraseResposta = e.toString();
            }
          }
        }
      }

      if (pergunta.startsWith(PC_PARA_FICAR)) {
        String provaDesejada =
            pergunta.contains(PC_PROVA1) ? 'Prova1' : 'Prova2';

        for (var disciplina in grade.disciplinas) {
          if (pergunta.contains(disciplina.nome.toLowerCase())) {
            try {
              String notaDesejada = pergunta[21].toUpperCase();
              Nota nota = disciplina.obterNota;
              String notaNecessaria =
                  nota.notaNecessaria(notaDesejada).toStringAsFixed(1);
              fraseResposta =
                  'A nota da $provaDesejada em ${disciplina.nome} deve ser $notaNecessaria';
            } catch (e) {
              fraseResposta = e.toString();
            }
          }
        }
      }
      if (fraseResposta == null) {
        this.respostas.add('Nem ideia do que isso significa');
      } else {
        this.respostas.add(fraseResposta);
      }
      fraseResposta = null;
    }
  }
}
