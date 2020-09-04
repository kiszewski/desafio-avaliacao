import 'models/disciplina.dart';
import 'models/gradeCurricular.dart';
import 'models/nota.dart';

GradeCurricular processarNotas(List<String> frases) {
  //Palavras Chaves ou PC:
  const String PC_MEDIA = 'media';
  const String PC_PROVA1 = 'prova1';
  const String PC_PROVA2 = 'prova2';

  final GradeCurricular gr = GradeCurricular([
    Disciplina('Logica Matematica', 4),
    Disciplina('Engenharia de Software', 6),
    Disciplina('Teoria da computacao', 3),
    Disciplina('Banco de Dados', 6),
    Disciplina('Arquitetura de Software', 4),
  ]);

  for (var frase in frases) {
    frase = frase.toLowerCase();

    for (var disciplina in gr.disciplinas) {
      if (frase.startsWith(disciplina.nome.toLowerCase())) {
        String notaLetra = frase[frase.length - 1].toUpperCase();

        if (frase.contains(PC_MEDIA)) {
          if (disciplina.temNota) {
            Nota notaExistente = disciplina.obterNota;
            notaExistente.inserirMedia(notaLetra);
            disciplina.definirNota(notaExistente);
          } else {
            disciplina.definirNota(Nota.notaEUA(media: notaLetra));
          }
        }
        if (frase.contains(PC_PROVA1)) {
          if (disciplina.temNota) {
            Nota notaExistente = disciplina.obterNota;
            notaExistente.inserirNota1(notaLetra);
            disciplina.definirNota(notaExistente);
          } else {
            disciplina.definirNota(Nota.notaEUA(nota1: notaLetra));
          }
        }
        if (frase.contains(PC_PROVA2)) {
          if (disciplina.temNota) {
            Nota notaExistente = disciplina.obterNota;
            notaExistente.inserirNota2(notaLetra);
            disciplina.definirNota(notaExistente);
          } else {
            disciplina.definirNota(Nota.notaEUA(nota2: notaLetra));
          }
        }
      }
    }
  }

  return gr;
}
