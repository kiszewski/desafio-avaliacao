import 'models/disciplina.dart';
import 'models/gradeCurricular.dart';
import 'models/nota.dart';

class ProcessarArquivo {
  final GradeCurricular gr = GradeCurricular([
    Disciplina('Logica Matematica', 4),
    Disciplina('Engenharia de Software', 6),
    Disciplina('Teoria da computacao', 3),
    Disciplina('Banco de Dados', 6),
    Disciplina('Arquitetura de Software', 4),
  ]);
  List<String> respostas = [];

  ProcessarArquivo(List<String> txt) {
    //Separar o que é pergunta e o que é frases
    List<String> frases =
        txt.where((element) => !element.endsWith('?')).toList();
    List<String> perguntas =
        txt.where((element) => element.endsWith('?')).toList();

    processarNotas(frases);
    processarPerguntas(perguntas);
  }

  processarNotas(List<String> frases) {
    //Palavras Chaves ou PC:
    const String PC_MEDIA = 'media';
    const String PC_PROVA1 = 'prova1';
    const String PC_PROVA2 = 'prova2';

    for (var frase in frases) {
      frase = frase.toLowerCase();

      for (var disciplina in this.gr.disciplinas) {
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
    const String PC_PONTUACAO_BRASILEIRA = 'pontuacao brasileira';
    const String PC_MATERIA = '';
    const String PC_APROVADO = 'aprovado';
    const String PC_TODAS_DISCIPLINAS = 'todas as disciplinas';
    const String PC_CREDITOS = 'creditos';
    const String PC_CURSOU = 'cursou';
    const String PC_CONCLUIU = 'concluiu';

    for (var pergunta in perguntas) {
      if (pergunta.contains(PC_MEDIA)) {
        for (var disciplina in this.gr.disciplinas) {
          if (pergunta.endsWith('${disciplina.nome}?')) {
            //Qual a media dessa disciplina:
            String resp;

            try {
              double media = disciplina.mediaDisciplina;
              resp =
                  'A media em ${disciplina.nome} foi de ${media.toStringAsFixed(1)}';
            } catch (e) {
              resp = e.toString();
            }

            this.respostas.add(resp);
          }
        }
      }

      if (pergunta.contains(PC_APROVADO) &&
          pergunta.contains(PC_TODAS_DISCIPLINAS)) {
        // Se o aluno foi aprovado em todas as disciplinas
        // Esse metodo considera somente as disciplinas com notas
        // Se o aluno for reprovado em mais de uma prova só sera exibido uma das notas que ele rodou

        String resp = gr.aprovadoEmTodas
            ? 'Sim, fui aprovado em todas disciplinas'
            : 'Não, reprovei em ${gr.disciplinasReprovadas[0].nome}';

        this.respostas.add(resp);
      } else if (pergunta.contains(PC_APROVADO)) {
        // Se o aluno foi aprovado em uma disciplina especifica

        for (var disciplina in gr.disciplinasComNotas) {
          if(pergunta.contains(disciplina.nome)) {
            String resp = disciplina.estaAprovado 
            ? 'Sim, fui aprovado em ${disciplina.nome} com media ${disciplina.mediaDisciplina.toStringAsFixed(1)}'
            : 'Não, fui reprovado em ${disciplina.nome} com media ${disciplina.mediaDisciplina.toStringAsFixed(1)}';

            this.respostas.add(resp);
          };
        }
      }
    }
  }
}
